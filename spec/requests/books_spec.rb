require 'rails_helper'

RSpec.describe "Books", type: :request do
  
  
  describe "index" do
    
    let!(:user) {FactoryBot.create(:user)}
    
    context "ログイン済みのユーザーの時" do
      
      it "正常にレスポンスを返す" do
        
        sign_in user
        
        get books_path
        
        expect(response).to be_success
      end
      
      it "200レスポンスを返す" do
        
        sign_in user
        
        get books_path
        
        expect(response).to have_http_status "200"
      end
    end
    
    context "ログイン済みでないユーザーの時" do
      
      it "302レスポンスを返す" do
        
        get books_path
        
        expect(response).to have_http_status "302"
      end
    end
    
  end
  
  
  describe "new" do
    
    let!(:user) {FactoryBot.create(:user)}
    
    context "ログイン済みのユーザーの時" do
      
      it "正常にレスポンスを返す" do
        
        sign_in user
        
        get new_book_path
        
        expect(response).to be_success
      end
      
      it "200レスポンスを返す" do
        
        sign_in user
        
        get new_book_path
        
        expect(response).to have_http_status "200"
      end
    end
    
    context "ログイン済みでないユーザーの時" do
      
      it "302レスポンスを返す" do
        
        get new_book_path
        
        expect(response).to have_http_status "302"
      end
    end
    
  end
  
  describe "create" do
    
    let!(:user) {FactoryBot.create(:user)}
    
    context "ログイン済みユーザーの時" do
      
      let!(:book) {FactoryBot.build(:book)}
      
      it "書籍登録できる" do
        
        sign_in user
        
        expect do
          post books_path, params: {book: {title: book.title, author: book.author, published: book.published, thumbnail: book.thumbnail, description: book.description}}
        end.to change(Book, :count).by(1)
      end
      
      it "books_pathにリダイレクトされる" do
        
        sign_in user
        
        post books_path, params: {book: {title: book.title, author: book.author, published: book.published, thumbnail: book.thumbnail, description: book.description}}
        
        expect(response).to redirect_to books_path
      end
    end
    
    context "ログイン済みでないユーザーの時" do
      
      let!(:book) {FactoryBot.build(:book)}
      
      it "書籍を登録できない" do
        
        expect do
          post books_path, params: {book: {title: book.title, author: book.author, published: book.published, thumbnail: book.thumbnail, description: book.description}}
        end.to_not change(Book, :count)
      end
      
      it "ログイン画面にリダイレクトされる" do
        
        post books_path, params: {book: {title: book.title, author: book.author, published: book.published, thumbnail: book.thumbnail, description: book.description}}
        
        expect(response).to redirect_to login_url
      end
    end
    
  end
  
  describe "destroy" do
    
    let!(:user) {FactoryBot.create(:user)}
    let!(:other_user) {FactoryBot.create(:user)}
    let!(:book) {FactoryBot.create(:book, user_id: user.id)}
    
    context "ログイン済みかつ現在のユーザーの時" do
      
      it "書籍を削除できる" do
        
        sign_in user
        
        expect do
          delete book_path(user), params: {id: book.id}
        end.to change(Book, :count).by(-1)
      end
      
      it "books_pathにリダイレクトされる" do
        
        sign_in user
        
        delete book_path(user), params: {id: book.id}
        
        expect(response).to redirect_to books_path
      end
    end
    
    context "ログイン済みかつ現在のユーザーで無いとき" do
      
      it "削除できない" do
        
        sign_in user
        
        expect do
          delete book_path(other_user), params: {id: book.id}
        end.to_not change(Book, :count)
      end
      
      it "topics_pathにリダイレクトされる" do
        
        sign_in user
        
        delete book_path(other_user), params: {id: book.id}
        
        expect(response).to redirect_to topics_path
      end
    end
    
    context "ログインしていないユーザーの時" do
      
      it "削除できない" do
        
        expect do
          delete book_path(other_user), params: {id: book.id}
        end.to_not change(Book, :count)
      end
      
      it "ログイン画面にリダイレクトされる" do
        
        delete book_path(other_user), params: {id: book.id}
        
        expect(response).to redirect_to login_url
      end
    end
  end
  
  
end