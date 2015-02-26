class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def order_status_change(user,order)    
    @user = user
    @order = order
    mail(to: @user.email, subject: 'Order Status')
  end

end
