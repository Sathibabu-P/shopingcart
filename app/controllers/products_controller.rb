class ProductsController < ApplicationController
  def index
    @products = Product.all.where(active: true)
    @order_item = current_order.order_items.new
  end
end
