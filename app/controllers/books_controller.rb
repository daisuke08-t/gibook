class BooksController < ApplicationController
  before_action :log_in_user
  before_action :correct_user, only: [:destroy]
  
  def index
    @books = current_user.books.paginate(page: params[:page], per_page: 10)
    @topic = Topic.new
  end
  
  def new
    @book = Book.new
    @topic = Topic.new
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    
    if @book.save
      redirect_to books_path, success: '書籍を登録しました'
    else
      flash.now[:danger] = '書籍を登録できませんでした'
      render :new
    end
  end
  
  def destroy
    book = Book.find_by(id: params[:id], user_id: current_user.id)
    book.destroy
    redirect_to books_path, success: '書籍を削除しました'
  end
  
  private
    
    def book_params
      params.require(:book).permit(:title, :author, :published, :thumbnail, :description)
    end
end
