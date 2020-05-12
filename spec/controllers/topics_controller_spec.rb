require 'rails_helper'

RSpec.describe TopicsController, type: :controller do
  
  describe "index" do
    
    context "ログイン済みのユーザーのとき" do
      
      before do
        
        @user = FactoryBot.create(:user)
        
      end
      
      it "正常にレスポンスを返す" do
        log_in @user
        get :index
        expect(response).to be_success
      end
      
      it "200レスポンスを返す" do
        log_in @user
        get :index
        expect(response).to have_http_status "200"
      end
    end
    
    context "ログイン済みでないユーザーの時" do
      
      it "302レスポンスを返す" do
        get :index
        expect(response).to have_http_status "302"
      end
      
      it "ログイン画面にリダイレクトされる" do
        get :index
        expect(response).to redirect_to login_url
      end
    end
  end
  
  describe "create" do
    
      
    context "ログイン済みのユーザーの時" do
      
      before do
        @user = FactoryBot.create(:user)
      end
      
      context "有効な属性の時" do
        
        it "topicを投稿できる" do
          
          topic_params = FactoryBot.attributes_for(:topic)
          log_in @user
          
          expect { post :create, params: {topic: topic_params}}.to change(@user.topics, :count).by(1)
        end
      end
      
      context "無効な属性の時" do
        
        it "topicを投稿できない" do
          
          topic_params = FactoryBot.attributes_for(:topic, :invalid)
          log_in @user
          
          expect { post :create, params: {topic: topic_params}}.to_not change(@user.topics, :count)
        end
      end
      
    end
    
    context "ログイン済みでないユーザーの時" do
      
      it "302レスポンスを返す" do
        
        topic_params = FactoryBot.attributes_for(:topic)
        
        post :create, params: {topic: topic_params}
        
        expect(response).to have_http_status "302"
      end
      
      it "ログイン画面にリダイレクトされる" do
        
        topic_params = FactoryBot.attributes_for(:topic)
        
        post :create, params: {topic: topic_params}
        
        expect(response).to redirect_to login_url
      end
    end
  end

end
