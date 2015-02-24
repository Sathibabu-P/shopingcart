class CheckoutsController < ApplicationController
before_action :authenticate_user!

	def index
		  @order_items = current_order.order_items
	end
	
end
