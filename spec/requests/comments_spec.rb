require 'rails_helper'

RSpec.describe "Example", type: :request do
  
  describe "new" do
    
    let!(:user) {FactoryBot.create(:user)}
    
    context "ログイン済みの時" do
      
      it "正常にレスポンスを返す" do
        
        sign_in user
        get comment_new_path
        
        expect(response).to be_success
      end
      
      it "200レスポンスを返す" do
        
        sign_in user
        get comment_new_path
        
        expect(response).to have_http_status "200"
      end
    end
    
    context "ログイン済みで無いとき" do
      
      it "302レスポンスを返す" do
        
        get comment_new_path
        
        expect(response).to have_http_status "302"
      end
      
      it "ログイン画面にリダイレクトされる" do
        
        get comment_new_path
        
        expect(response).to redirect_to login_url
      end
    end
    
  end
  
  
  describe "create" do
    
    let!(:user) {FactoryBot.create(:user)}
    let!(:other_user) {FactoryBot.create(:user)}
    let!(:topic) {FactoryBot.create(:topic, user_id: other_user.id)}
    
    context "ログイン済みで有効な属性であるとき" do
      
        let!(:comment) {FactoryBot.build(:comment)}
      
      it "投稿にコメントできる" do
        
        sign_in user
        
        
        expect do
          post comments_path, params: {comment: comment }, params: {comment: {topic_id: topic.id}}
        end.to change(Comment, :count).by(1)
      end
      
      it "topics_pathにリダイレクトされる" do
        
        sign_in user
        
        post comments_path, params: {comment: comment }, params: {comment: {topic_id: topic.id}}
        
        expect(response).to redirect_to topics_path
      end
    end
    
    context "ログイン済みでないとき" do
      
      let!(:comment) {FactoryBot.build(:comment)}
      
      it "投稿にコメントできない" do
        
        expect do
          post comments_path, params: {comment: comment }, params: {comment: {topic_id: topic.id}}
        end.to_not change(Comment, :count)
      end
      
      it "ログイン画面にリダイレクトされる" do
        
        post comments_path, params: {comment: comment }, params: {comment: {topic_id: topic.id}}
        
        expect(response).to redirect_to login_url
      end
    end
    
  end
  
  
  describe "destroy" do
    
    let!(:user) {FactoryBot.create(:user)}
    let!(:other_user) {FactoryBot.create(:user)}
    let!(:topic) {FactoryBot.create(:topic, user_id: other_user.id)}
    let!(:comment) {FactoryBot.create(:comment, user_id: user.id, topic_id: topic.id)}
    
    context "ログイン済みかつ現在のユーザーであるとき" do
      
      it "コメントを削除できる" do
        
        sign_in user
        
        expect do
          delete comment_delete_path, params: {id: comment.id}
        end.to change(Comment, :count).by(-1)
      end
      
      it "topics_pathにリダイレクトされる" do
        
        sign_in user
        
        delete comment_delete_path, params: {id: comment.id}
        
        expect(response).to redirect_to topics_path
      end
    end
    
    context "ログイン済みでないとき" do
      
      it "コメントを削除できない" do
        
        expect do
          delete comment_delete_path, params: {id: comment.id}
        end.to_not change(Comment, :count)
      end
      
      it "ログイン画面にリダイレクトされる" do
        
        delete comment_delete_path, params: {id: comment.id}
        
        expect(response).to redirect_to login_url
      end
    end
    
  end
  
  
end