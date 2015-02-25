# require 'google_calendar'
class Paypal < ActiveRecord::Base
	belongs_to :user
	validates :name, :cardno, :presence => true
	# after_save :update_googlecalender

	private
# 	def update_googlecalender

# 		# Create an instance of the calendar.
# cal = Google::Calendar.new(:client_id     => "931434174427-0o3e9ndqaccckv48hdfjg7mvftj45s7r.apps.googleusercontent.com", 
#                            :client_secret => "D-u1geQ1A741x4grmYDbdK1a",
#                            :calendar      => "sathibabu.nyros@gmail.com",
#                            :redirect_url  =>"http://localhost:3000",
#       					   :access_type=>"offline" # this is what Google uses for 'applications'
#                            )

# 	cal.login_with_refresh_token("1/11OHyRP8DVmC5ceDlNC_uGdk8QBUhM5Iwg_lCgEBLFoMEudVrK5jSpoR30zcRFq6")
	
# 	    if self.google_event_id.blank?

# 		      event = cal.create_event do   |e|
# 		        e.title = self.editor.name
# 		        e.start_time = "#{self.schedule_date}T#{self.time_in}"
# 		        e.end_time = "#{self.schedule_date}T#{self.time_out}"
# 		      end#event
# 		      self.update_attribute("google_event_id",event.id)
		    
# 		    else

# 		      event = cal.find_or_create_event_by_id(self.google_event_id) do |e|
# 		        e.title = self.editor.name
# 		        e.start_time = "#{self.schedule_date}T#{self.time_in}"
# 		        e.end_time = "#{self.schedule_date}T#{self.time_out}"
# 		      end#event

#         end #if self.google_event_id.blank?

# 	end
end
