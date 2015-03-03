require 'google/api_client'
require 'tod'
class Event < ActiveRecord::Base
 #serialize :start_time, Tod::TimeOfDay 
 #serialize :end_time, Tod::TimeOfDay	
 #before_save :set_timeformat
 after_save :set_googlecalender
		rails_admin do   
		   
		   list do
		     field :name 
		     field :eventdate
		      field :start_time  #do
		    #  formatted_value do # used in form views
      #     		time = value.to_s.split(":")
      #     		TimeOfDay.new(time[0],time[1]).strftime("%I:%M %p")
	     #    end
	    	# end
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
  			# time = self.start_time.to_s.split(":")
  			# time = self.end_time.to_s.split(":")
  			# start_time = TimeOfDay.new(time[0],time[1]).strftime("%I:%M %p")
  			# end_time = TimeOfDay.new(time[0],time[1]).strftime("%I:%M %p")
  			#Create an instance of the calendar.
		cal = Google::Calendar.new(:client_id     => "898970169350-ua3qo7du52na0n1gv6jg13goa50enos4.apps.googleusercontent.com", 
                           :client_secret => "LQSyP_l3DVEeNzvBKq1CaKsP",
                           :calendar      => "sathibabu.nyros@gmail.com",
                           :redirect_url  => "http://localhost:3000" # this is what Google uses for 'applications'
                           )
			cal.login_with_refresh_token('1/gAhIPwXKVf3uhq4YKVXNB0mOy8cKU3dVxb2dBfestfQ')
			

	    if self.google_event_id.blank?

		      event = cal.create_event do   |e|
		        e.title = self.name
		        e.start_time = "#{self.eventdate}T#{start_time}"
		        e.end_time = "#{self.eventdate}T#{end_time}"
		      end#event
		      self.update_attribute("google_event_id",event.id)
		    
		    else

		      event = cal.find_or_create_event_by_id(self.google_event_id) do |e|
		        e.title = self.name
		        e.start_time = "#{self.eventdate}T#{start_time}"
		        e.end_time = "#{self.eventdate}T#{end_time}"
		      end#event

            end #if self.google_event_id.blank?
		end

		# def set_timeformat
		# 	time = self.start_time.to_s.split(" ")
		# 	self.start_time = time[0]
		# 	time = self.end_time.to_s.split(" ")
		# 	self.end_time = time[0]
			
		# 	#TimeOfDay.try_parse "#{end_time.to_s}"	
 	# 	end
end
