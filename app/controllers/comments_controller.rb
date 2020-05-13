class CommentsController < ApplicationController
  before_action :log_in_user
  
  def new
    @comment = Comment.new
    @topic_id = params[:topic_id]
  end
  
  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.topic_id = params[:comment][:topic_id]
    if @comment.save
      redirect_to topics_path, success: 'コメントしました'
    else
      flash.now[:danger] = 'コメントできませんでした'
      render :new
    end
  end
  
  def destroy
    uncomment = Comment.find(params[:id])
    uncomment.destroy
    redirect_to topics_path, success: 'コメントを削除しました'
  end
  
  
  private
    
    def comment_params
      params.require(:comment).permit(:content)
    end
  
end
