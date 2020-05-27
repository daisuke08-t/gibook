class TopicsController < ApplicationController
  before_action :log_in_user, only: [:index, :new, :create, :destroy]
  before_action :correct_user, only: [:destroy]
  before_action :error_params, only: [:new]
  
  def index
    @topics = Topic.paginate(page: params[:page], per_page: 10)
    @book = Book.new
  end
  
  
  def new
    #unless
      @topic = Topic.new
    #else
     # redirect_to topics_path, danger: 'Search booksより書籍のタイトルを検索して下さい'
    #end
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
    #binding.pry
    topic.destroy
    redirect_to this_user_topics_user_path(id: current_user.id), danger: '投稿を削除しました'
  end
  
  private
    
    def topic_params
      params.require(:topic).permit(:title, :author, :thumbnail, :published, :description, :content)
    end
    
    #params[:topic][:title]がない場合のnewへのアクセスを制限
    def error_params
      begin
        params[:topic][:title]
      rescue 
        redirect_to topics_path, danger: 'Search Booksから投稿を行ってください'
      end
    end
  
end
