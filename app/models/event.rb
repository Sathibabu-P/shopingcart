require 'google/api_client'
require 'chronic'
class Event < ActiveRecord::Base
#after_save :set_googlecalender
		rails_admin do   
		   
		   list do
		     field :name 
		     field :eventdate
		     field :start_time
		     field :end_time
		    end

		     edit do 
		   	 field :name
      		 field :eventdate
      		 field :start_time
      		 field :end_time         
		   end
  		end

  		private

  		def current_admin   
		    @admin = Admin.last		    
		end
	    

  		def set_googlecalender

  	
  			#Create an instance of the calendar.
			cal = Google::Calendar.new(:client_id     => "866050588215-k8ql7cas15qci4ciuvoohl8q4stbifvi.apps.googleusercontent.com", 
                           :client_secret => "iwrIXVRKS-OeJm2syWf8iGPw",
                           :calendar      => "sathibabu.nyros@gmail.com",
                           :redirect_url  => "http://localhost:3000" # this is what Google uses for 'applications'
                           )
			cal.login_with_refresh_token('4/8OEjTy7VWKacA7xDfS3kKXgSW6nd2kaOnpnKUd8Xcbc.cktIbKy_5coTcp7tdiljKKZ5LcyIlwI')
			

	    if self.google_event_id.blank?

		      event = cal.create_event do   |e|
		        e.title = self.name
		        e.start_time = "#{self.eventdate}T#{self.start_time}"
		        e.end_time = "#{self.eventdate}T#{self.end_time}"
		      end#event
		      self.update_attribute("google_event_id",event.id)
		    
		    else

		      event = cal.find_or_create_event_by_id(self.google_event_id) do |e|
		        e.title = self.name
		        e.start_time = "#{self.eventdate}T#{self.start_time}"
		        e.end_time = "#{self.eventdate}T#{self.end_time}"
		      end#event

            end #if self.google_event_id.blank?
		end
end
