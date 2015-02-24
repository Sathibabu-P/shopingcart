class AddCustomerIdToPaypal < ActiveRecord::Migration
  def change
    add_column :paypals, :braintree_customer_id, :integer
  end
end
