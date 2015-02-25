
class PaypalsController < ApplicationController	
  before_action :authenticate_user!
	def index
		@paypal = Paypal.new
    @order_items = current_order.order_items
	end

	 # POST /students
  # POST /students.json
     # POST /students
  # POST /students.json
  def create
    @paypal = Paypal.new(paypal_params)  
    @paypal.user_id = current_user.id if current_user
    respond_to do |format|
      if @paypal.save 

        result = Braintree::Customer.create(
        :first_name => 'Charity',     
        :credit_card => {
          :number =>  params[:paypal][:cardno],
          :expiration_date => "05/2020",
        }
      )
      if result.success?
        @paypal.braintree_customer_id = result.customer.id
        @paypal.save
        @order = current_order
        @order.user_id = current_user.id if current_user
        @order.save
        session.delete(:order_id)
        format.html { redirect_to root_path, notice: 'Your Order was successfully Placed.' }
        format.json { render :show, status: :created, location: root_path }
      else
        @paypal.destroy 
        format.html { redirect_to paypals_path,notice: 'In Valid credit card details.' }
           # format.json { render json: result.errors, status: :unprocessable_entity }
      end
      else
        format.html { render :index }
        format.json { render json: @paypal.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  
    

    # Never trust parameters from the scary internet, only allow the white list through.
    def paypal_params
      params.require(:paypal).permit(:name,:cardno,:expdate,:cvv_no)
    end

end
