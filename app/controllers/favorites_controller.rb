class FavoritesController < ApplicationController
  
  def index
    @user = User.find_by(id: params[:user_id])
    @favorites = Favorite.where(user_id: params[:user_id])
    #binding.pry
  end
  
  def create
    favorite = Favorite.new
    favorite.user_id = current_user.id
    favorite.topic_id = params[:topic_id]
    
    if favorite.save
      redirect_to topics_path, success: '投稿をお気に入りしました'
    else
      redirect_to topics_path, danger: 'お気に入りにできませんでした'
    end
  end
  
  def destroy
    unfavorite = Favorite.find_by(params[:topic_id])
    unfavorite.destroy
    redirect_to topics_path, success: 'お気に入りを解除しました'
  end
  
end
