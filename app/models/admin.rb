class Admin < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:google_oauth2]
         rails_admin do   
		   visible true
  		end


def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = Admin.where(:provider => access_token.provider, :uid => access_token.uid ).first
    if user
      return user
    else
      registered_user = Admin.where(:email => access_token.info.email).first
      if registered_user
        return registered_user
      else
        user = Admin.create(
          provider:access_token.provider,
          email: data["email"],
          uid: access_token.uid ,
          token: access_token.credentials.token,
          password: Devise.friendly_token[0,20],
        )
      end
   	end
end
		
end
