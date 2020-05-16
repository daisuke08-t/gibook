module SessionsHelper
  
  #引数のuserでログインする
  def log_in(user)
      session[:user_id] = user.id
  end
  
  #現在のユーザーをログアウトさせる
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end
  
  #ユーザーのセッションを永続的にする
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end
  
  #永続セッションを破棄する
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
  
  
  
end
