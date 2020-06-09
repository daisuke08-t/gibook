module ApplicationHelper
  
  #記憶トークンに対応するユーザーを返す
  def current_user
    if user_id = session[:user_id]
      @current_user ||= User.find_by(id: user_id)
    elsif user_id = cookies.signed[:user_id]
      user = User.find_by(id: user_id)
      
      if user && user.authenticated?[:remember_token]
        log_in user
        @current_user = user
      end
    end
  end
  
  #ログインしているかを確認
  def logged_in?
    !current_user.nil?
  end
  
  #現在のユーザーであるかを確認
  def current_user?(user)
    current_user.id === user.id
  end
  
  #ログインしていない場合はログインするように要求
  def log_in_user 
    unless logged_in?
      flash.now[:danger] = 'ログインしてください'
      redirect_to login_url
    end
  end
  
  
  #ユーザーが現在のユーザーと一致しない場合、ホームに返す（アクセス制限）
  def correct_user
    @user = User.find(params[:id])
    redirect_to topics_path unless @user === current_user
  end
  
end
