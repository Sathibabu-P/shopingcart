class ProductsController < ApplicationController
  def index
    @products = Product.all.where(active: true)
    @order_item = current_order.order_items.new if @products.size > 0
  end
end
