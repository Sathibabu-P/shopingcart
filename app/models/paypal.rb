class Paypal < ActiveRecord::Base
	belongs_to :user
	validates :name, :cardno, :presence => true
end
