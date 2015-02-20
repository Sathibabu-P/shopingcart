class ApplicationController < ActionController::Base
 layout :layout_by_resource

  protected

  def layout_by_resource
    if devise_controller?
      "admin"
    else
      "application"
    end
  end
  protect_from_forgery with: :exception
  helper_method :current_order

  def current_order
    if !session[:order_id].nil?
      Order.find(session[:order_id])
    else
      Order.new
    end
  end
end
