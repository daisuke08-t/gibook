class TopicsController < ApplicationController
  
  def index
    @topics = Topic.all
  end
  
  
  def new
    @topic = Topic.new
  end
  
  def create 
    @topic = current_user.topics.new(topic_params)
    
    if @topic.save
      redirect_to topics_path, success: '投稿しました'
    else
      flash.now[:danger] = '投稿に失敗しました'
      render :new
    end
  end
  
  def destroy
    topic = Topic.find_by(id: params[:id], user_id: current_user.id)
    
    topic.destroy
    redirect_to this_user_topics_user_path(id: current_user.id), danger: '投稿を削除しました'
  end
  
  private
    
    def topic_params
      params.require(:topic).permit(:title, :author, :thumbnail, :published, :description, :content)
    end
  
end
