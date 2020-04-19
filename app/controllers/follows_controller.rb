class FollowsController < ApplicationController
  before_action :logged_in?
  
  def create
    user = User.find_by(params[:followed_id])
    current_user.follow(user)
    redirect_to user
  end
  
  def destroy
    user = User.find_by(params[:followd_id])
    current_user.unfollow(user)
    redirect_to user
  end
  
end
