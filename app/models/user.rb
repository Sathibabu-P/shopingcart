require 'twilio-ruby' 
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         has_many :paypals
         has_many :orders
     #     accepts_nested_attributes_for :orders, allow_destroy: true
  		 # attr_accessor :orders_attributes

  after_create :send_sms_to_user, :send_mail_to_admin
  

  private

  		def send_mail_to_admin  			
	  	# Sends email to user when user is created.
	      AdminMailer.newuser_reg(self).deliver
  		end

      def send_sms_to_user 

          # put your own credentials here 
          account_sid = 'AC941d8965332f274e97244afafb1c17da' 
          auth_token = '438d07c35fba5ddde1a9522ce673b789' 
         begin  
          # set up a client to talk to the Twilio REST API 
          @client = Twilio::REST::Client.new account_sid, auth_token 
           
          @client.account.messages.create({
            :from => '+15305136083', 
            :to => '+919966887143', 
            :body => "send Y-#{self.id} to acccept, or N-#{self.id} to reject",  
          })

          rescue Twilio::REST::RequestError => e
            return e.message
         end

      end


end
