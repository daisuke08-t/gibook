require 'rails_helper'

RSpec.describe FavoritesController, type: :controller do
  
  describe "index" do
    
    let(:user) {FactoryBot.create(:user)}
    let(:other_user) {FactoryBot.create(:user)}
    
    context "ログイン済みの時" do
      
      it "正常にレスポンスを返す" do
        
        log_in user
        
        get :index, params: {user_id: user.id}
        
        expect(response).to be_success
      end
      
      it "200レスポンスを返す" do
        
        log_in user
        
        get :index, params: {user_id: user.id}
        
        expect(response).to have_http_status "200"
      end
    end
    
    context "ログイン済みでない時" do
      
      it "ログイン画面にリダイレクトされる" do
        
        get :index, params: {user_id: user.id}
        
        expect(response).to redirect_to login_url
      end
    end
    
  end
  
  describe "create" do
    
    let(:user) {FactoryBot.create(:user)}
    let(:other_user) {FactoryBot.create(:user)}
    let(:topic) {FactoryBot.create(:topic, user_id: other_user.id)}
    
    context "ログイン済みの時" do
      
      it "お気に入りできる" do
        
        log_in user
        
        expect {post :create, params: {topic_id: topic.id}}.to change(user.favorites, :count).by(1)
      end
      
      it "topics_pathにリダイレクトされる" do
        
        log_in user
        
        post :create, params: {topic_id: topic.id}
        
        expect(response).to redirect_to topics_path
      end
    end
    
    context "ログイン済みでない時" do
      
      it "お気に入りできない" do
        
        expect {post :create, params: {topic_id: topic.id}}.to_not change(user.favorites, :count)
      end
      
      it "ログイン画面にリダイレクトされる" do
        
        post :create, params: {topic_id: topic.id}
        
        expect(response).to redirect_to login_url
      end
    end
  end
  
  describe "destroy" do
    
    let(:user) {FactoryBot.create(:user)}
    let(:other_user) {FactoryBot.create(:user)}
    let(:topic) {FactoryBot.create(:topic, user_id: other_user.id)}
    
    context "ログイン済みの時" do
      
      it "お気に入りを解除できる" do
        
        log_in user
        
        post :create, params: {topic_id: topic.id}
        expect {delete :destroy, params: {topic_id: topic.id}}.to change(user.favorites, :count).by(-1)
      end
      
      it "topics_pathにリダイレクトされる" do
       
       log_in user
       
       post :create, params: {topic_id: topic.id}
       delete :destroy, params: {topic_id: topic.id} 
       
       expect(response).to redirect_to topics_path
     end
    end
    
    context "ログイン済みでないとき" do
      
      it "お気に入りを解除できない" do
        
        expect {delete :destroy, params: {topic_id: topic.id}}.to_not change(user.favorites, :count)
      end
      
      it "ログイン画面にリダイレクトされる" do
        
        delete :destroy, params: {topic_id: topic.id} 
        
        expect(response).to redirect_to login_url
      end
    end
  end

end
