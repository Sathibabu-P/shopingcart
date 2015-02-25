class Order < ActiveRecord::Base
  belongs_to :order_status
  belongs_to :user
  has_many :order_items
  before_create :set_order_status
  before_save :update_subtotal
  # accepts_nested_attributes_for :user, allow_destroy: true
  # attr_accessor :user_attributes
  #attr_accessor :attribute_name

  def subtotal
    order_items.collect { |oi| oi.valid? ? (oi.quantity * oi.unit_price) : 0 }.sum
  end


     rails_admin do        
       list do
         field :id do
          label 'Order ID'         
        end

        
    
        field :user do
          pretty_value do
          user_id = bindings[:object].user_id
          email = bindings[:view].email(user_id)
          bindings[:view].link_to "#{email}", bindings[:view].rails_admin.show_path('user', user_id)
        end
        end


         field :subtotal  do
          label 'Order Total'         
         end

         field :order_status_id do
         
        pretty_value do
         order = OrderStatus.find(bindings[:object].order_status_id.to_s)
         order.name
        end
      end  


         field :created_at do
          label 'Order Placed on'
         end
        end
      end

       
       

private
  def set_order_status
    self.order_status_id = 1
  end

  def update_subtotal
    self[:subtotal] = subtotal
  end

  

end
