class AddOauthToAdmin < ActiveRecord::Migration
  def change
    add_column :admins, :token, :string
    add_column :admins, :uid, :string
    add_column :admins, :provider, :string
  end
end
