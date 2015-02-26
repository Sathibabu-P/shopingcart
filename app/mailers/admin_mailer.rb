class AdminMailer < ActionMailer::Base
  default from: "from@example.com"

  def newuser_reg(user)
    @user = user
    adminemail = Admin.last.email
    mail(to: adminemail, subject: 'Sample Email')
  end

  def orderscheck(order)
    @order = order
    mail(to: adminemail, subject: 'New Order Report')
  end

end
