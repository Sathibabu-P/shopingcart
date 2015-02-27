class ApplicationController < ActionController::Base
 layout :layout_by_resource
 
  protected
  # def current_user
  #   return unless session[:user_id]
  #   @current_user ||= User.find(session[:user_id])
  # end

  def layout_by_resource
    if devise_controller? && !current_user.blank?
      "admin"
    else
      "application"
    end
  end
  protect_from_forgery with: :exception
  helper_method :current_order

  def current_order
    if !session[:order_id].nil?
      Order.find_by_id(session[:order_id])
    else
      Order.new
    end
  end

  def reply_sms
    UserMailer.verify_phonenumber(id).deliver
     #  reply = params[:Body].gsub("-\d","")     
     # if reply == "Y"
     #    id = params[:Body].gsub("Y-","") 
     #    UserMailer.verify_phonenumber(id).deliver
     # else
     #   id = params[:Body].gsub("N-","") 
     #  UserMailer.verify_phonenumber(id).deliver
     # end
  end

   

end
