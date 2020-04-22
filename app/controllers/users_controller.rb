class UsersController < ApplicationController
  before_action :log_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]
  
  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  
  def create
    @user = User.new(user_params)
    #@user.icon = 'icon/user-icon.jpg'
    
    if @user.save
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
  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :icon, :content, :password, :password_confirmation)
    end
  
end
