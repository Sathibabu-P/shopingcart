require 'google_calendar'
class Event < ActiveRecord::Base
after_save :set_googlecalender
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

  		def set_googlecalender
  			#Create an instance of the calendar.
cal = Google::Calendar.new(:client_id     => "866050588215-17kae470c3i367htk0a8cf8tch1sk329.apps.googleusercontent.com", 
                           :client_secret => "HGanFiu3X_M8KPUbIOZyamn8",
                           :calendar      => "sathibabu.nyros@gmail.com",
                           :redirect_url  =>"http://localhost:3000"      					  
                           )

	#cal.login_with_refresh_token("1/11OHyRP8DVmC5ceDlNC_uGdk8QBUhM5Iwg_lCgEBLFoMEudVrK5jSpoR30zcRFq6")
		puts "Do you already have a refresh token? (y/n)"
has_token = $stdin.gets.chomp

if has_token.downcase != 'y'

  # A user needs to approve access in order to work with their calendars.
  puts "Visit the following web page in your browser and approve access."
  puts cal.authorize_url
  puts "\nCopy the code that Google returned and paste it here:"

  # Pass the ONE TIME USE access code here to login and get a refresh token that you can use for access from now on.
  refresh_token = cal.login_with_auth_code( $stdin.gets.chomp )

  puts "\nMake sure you SAVE YOUR REFRESH TOKEN so you don't have to prompt the user to approve access again."
  puts "your refresh token is:\n\t#{refresh_token}\n"
  puts "Press return to continue"
  $stdin.gets.chomp

else

  puts "Enter your refresh token"
  refresh_token = $stdin.gets.chomp
  cal.login_with_refresh_token("4/RgNM8vC8DW5ht1qF2BKDKQQ_VG6adEGB3Ox4hz53EOw.wtjS0hfD51QXcp7tdiljKKYrBQ6BlwI")

  # Note: You can also pass your refresh_token to the constructor and it will login at that time.

end

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
