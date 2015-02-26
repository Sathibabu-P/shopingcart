module ApplicationHelper
  def email(user_id)
  user = User.find(user_id) 
  user.email 
  end 
end
