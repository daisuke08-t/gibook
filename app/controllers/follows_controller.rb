class FollowsController < ApplicationController
  before_action :log_in_user
  
  def create
    user = User.find(params[:followed_id])
    current_user.follow(user)
    redirect_to user
  end
  
  def destroy
    user = Follow.find(params[:id]).followed
    current_user.unfollow(user)
    redirect_to user
  end
  
end
