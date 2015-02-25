class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         has_many :paypals
         has_many :orders
     #     accepts_nested_attributes_for :orders, allow_destroy: true
  		 # attr_accessor :orders_attributes
end
