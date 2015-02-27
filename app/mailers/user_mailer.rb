class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def order_status_change(user,order)    
    @user = user
    @order = order
    mail(to: @user.email, subject: 'Order Status')
  end

  def verify_phonenumber(id)
  	@user = User.find_by_id(id)
  	mail(to: @user.email, subject: 'Your Phone number is Verfied')
  end

end
