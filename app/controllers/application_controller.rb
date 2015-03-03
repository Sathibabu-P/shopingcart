class ApplicationController < ActionController::Base
 layout :layout_by_resource
 
 def reply_sms
    UserMailer.verify_phonenumber.deliver
     #  reply = params[:Body].gsub("-\d","")     if !params[:Body].blank?
     # if reply == "Y" && params[:Body]
     #    id = params[:Body].gsub("Y-","") 
     #    UserMailer.verify_phonenumber(id).deliver
     # elsif reply == "N"
     #   id = params[:Body].gsub("N-","") 
     #  UserMailer.verify_phonenumber(id).deliver
     # end
     render :text => "Verified Sucess"
 end

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

  

   

end
