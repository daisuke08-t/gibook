module ApplicationHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
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
    redirect_to (root_url) unless @user === current_user
  end
end
