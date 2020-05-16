module AuthenticationHelper
  
  def login(user)
    @user = user
    cookies[:auth_token] = @user.auth_token
  end
  
  def logout
    @user = nil
    @auth_token = nil
  end
  
end