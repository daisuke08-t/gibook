require 'rails_helper'

RSpec.describe "Favorites", type: :request do
  
  describe "index" do
    
    let!(:user) {FactoryBot.create(:user)}
    let!(:other_user) {FactoryBot.create(:user)}
    
    context "ログイン済みの時" do
      
      it "正常にレスポンスを返す" do
        
        sign_in user
        
        get favorites_path, params: {user_id: user.id}
        
        expect(response).to be_success
      end
      
      it "200レスポンスを返す" do
        
        sign_in user
        
        get favorites_path, params: {user_id: user.id}
        
        expect(response).to have_http_status "200"
      end
    end
    
    context "ログイン済みでない時" do
      
      it "ログイン画面にリダイレクトされる" do
        
        get favorites_path, params: {user_id: user.id}
        
        expect(response).to redirect_to login_url
      end
    end
    
  end
  
  
  describe "create" do
    
    let!(:user) {FactoryBot.create(:user)}
    let!(:other_user) {FactoryBot.create(:user)}
    let!(:topic) {FactoryBot.create(:topic, user_id: other_user.id)}
    
    context "ログイン済みの時" do
      
      it "お気に入りできる" do
        
        sign_in user
        
        expect {post favorites_path, params: {topic_id: topic.id}}.to change(user.favorites, :count).by(1)
      end
      
      it "topics_pathにリダイレクトされる" do
        
        sign_in user
        
        post favorites_path, params: {topic_id: topic.id}
        
        expect(response).to redirect_to topics_path
      end
    end
    
    context "ログイン済みでない時" do
      
      it "お気に入りできない" do
        
        expect {post favorites_path, params: {topic_id: topic.id}}.to_not change(user.favorites, :count)
      end
      
      it "ログイン画面にリダイレクトされる" do
        
        post favorites_path, params: {topic_id: topic.id}
        
        expect(response).to redirect_to login_url
      end
    end
  end
  
  describe "destroy" do
    
    let!(:user) {FactoryBot.create(:user)}
    let!(:other_user) {FactoryBot.create(:user)}
    let!(:topic) {FactoryBot.create(:topic, user_id: other_user.id)}
    
    context "ログイン済みの時" do
      
      let!(:favorite) {FactoryBot.create(:favorite, user_id: user.id, topic_id: topic.id)}
      
      it "お気に入りを解除できる" do
        
        sign_in user
        
        expect {delete favorites_delete_path, params: {topic_id: topic.id}}.to change(user.favorites, :count).by(-1)
      end
      
      it "topics_pathにリダイレクトされる" do
       
       sign_in user
       
       delete favorites_delete_path, params: {topic_id: topic.id} 
       
       expect(response).to redirect_to topics_path
     end
    end
    
    context "ログイン済みでないとき" do
      
      it "お気に入りを解除できない" do
        
        expect {delete favorites_delete_path, params: {topic_id: topic.id}}.to_not change(user.favorites, :count)
      end
      
      it "ログイン画面にリダイレクトされる" do
        
        delete favorites_delete_path, params: {topic_id: topic.id} 
        
        expect(response).to redirect_to login_url
      end
    end
  end
  
end