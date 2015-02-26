class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         has_many :paypals
         has_many :orders
     #     accepts_nested_attributes_for :orders, allow_destroy: true
  		 # attr_accessor :orders_attributes

  after_create :send_mail_to_admin
  

  private

  		def send_mail_to_admin  			
	  	# Sends email to user when user is created.
	      AdminMailer.newuser_reg(self).deliver
  		end

end
