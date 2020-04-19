module ApplicationHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  
  def logged_in?
    !current_user.nil?
  end
  
  def current_user?(user)
    current_user.id === user.id
  end
end
