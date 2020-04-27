class SessionsController < ApplicationController
  def new
  end
  
  def create
    @user = User.find_by(email_params)
    
    if @user && @user.authenticate(password_params[:password])
      log_in @user
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      redirect_to root_path, success: 'ログインしました'
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render :new
    end
  end
  
  def destroy
    log_out if logged_in?
    redirect_to root_url, info: 'ログアウトしました'
  end
  
  
  private
    
    def email_params
      params.require(:session).permit(:email)
    end
    
    def password_params
      params.require(:session).permit(:password)
    end
  
end
