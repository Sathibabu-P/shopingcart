require 'rails_admin/config/actions'
require 'rails_admin/config/actions/base'
 

module RailsAdmin
  module Config
    module Actions
      class Ordershow < RailsAdmin::Config::Actions::Base
        # There are several options that you can set here.
        # Check https://github.com/sferik/rails_admin/blob/master/lib/rails_admin/config/actions/base.rb for more info.
          
           # This ensures the action only shows up for Order
        register_instance_option :visible? do
          authorized? && bindings[:object].class == Order
        end
        # We want the action on members, not the Order collection
        register_instance_option :member do
          true
        end
        register_instance_option :link_icon do
          'icon-th-list'
        end

        register_instance_option :http_methods do
          [:get,:post]
        end

 
        register_instance_option :controller do
          Proc.new do
            # Get all selected rows
            @order_items =  OrderItem.all
            #redirect_to back_or_index    
           
          end
        end
      end
    end
  end
end
