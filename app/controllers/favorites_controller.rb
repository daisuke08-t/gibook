class FavoritesController < ApplicationController
  before_action :log_in_user
  
  def index
    @user = User.find_by(id: params[:user_id])
    @favorites = @user.favorites.paginate(page: params[:page], per_page: 10)
    @book = Book.new
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
    unfavorite = Favorite.find_by(topic_id: params[:topic_id], user_id: current_user.id)
    unfavorite.destroy
    redirect_to topics_path, success: 'お気に入りを解除しました'
  end
  
end
