namespace :orderscheck do
  desc "Rake task to get orders data"
      task :changeorderstatus => :environment do
        @orders = Order.all.where(order_status_id: 1)
        if @orders.count > 0
          @orders.each do |order|
            order.order_status_id = 2
            order.save
            @user = User.find_by_id(order.user_id)
            UserMailer.order_status_change(@user,order).deliver
          end
        end
        puts "#{Time.now} - Success!"
      end
end