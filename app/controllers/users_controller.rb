class UsersController < ApplicationController
  before_action :log_in_user, only: [:edit, :update, :following, :followers, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:destroy]
  
  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def this_user_topics
    @user = User.find(params[:id])
  end
  
  
  def create
    @user = User.new(user_params)
    #@user.icon = 'icon/user-icon.jpg'
    
    if @user.save
      log_in @user
      redirect_to root_path, success: '登録が完了しました'
    else
      flash.now[:danger] = '登録に失敗しました'
      render :new
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    
    if @user.update_attributes(user_params)
      redirect_to @user, success: 'ユーザー情報を更新しました'
    else
      render :edit
    end
  end
  
  def following
    @user = User.find(params[:id])
    @users = @user.following
  end
  
  def followers
    @user = User.find(params[:id])
    @users = @user.followers
  end
  
  def destroy
    User.find(params[:id]).destroy
    redirect_to current_user, success: 'ユーザーを削除しました'
  end
  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :icon, :content, :password, :password_confirmation)
    end
    
    def admin_user
      redirect_to topics_path unless current_user.admin?
    end
  
end
