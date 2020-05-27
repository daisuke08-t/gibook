require 'rails_helper'

RSpec.describe "Topics", type: :request do
  
  describe "index" do
    
    context "ログイン済みのユーザーのとき" do
      
        
      let(:user) {FactoryBot.create(:user)}
      
      it "正常にレスポンスを返す" do
        sign_in user
        get topics_path
        expect(response).to be_success
      end
      
      it "200レスポンスを返す" do
        sign_in user
        get topics_path
        expect(response).to have_http_status "200"
      end
    end
    
    context "ログイン済みでないユーザーの時" do
      
      it "302レスポンスを返す" do
        get topics_path
        expect(response).to have_http_status "302"
      end
      
      it "ログイン画面にリダイレクトされる" do
        get topics_path
        expect(response).to redirect_to login_url
      end
    end
  end
  
  
  describe "new" do
    
    context "ログイン済みのユーザーの時" do
      
      let(:user) {FactoryBot.create(:user)}
      
      context "有効な値を持っているとき" do
        
        let(:topic) {FactoryBot.build(:topic)}
        
        it "正常にレスポンスを返す" do
          
          sign_in user
          
          get new_topic_path, params: {topic: {title: topic.title}}
          
          expect(response).to be_success
        end
        
        it "200レスポンスを返す" do
          
          sign_in user
          
          get new_topic_path, params: {topic: {title: topic.title}}
          
          expect(response).to have_http_status "200"
        end
      end
      
      context "有効な値を持っていないとき" do
        
        it "302レスポンスを返す" do
          
          sign_in user
          
          get new_topic_path
          
          expect(response).to have_http_status "302"
        end
        
        it "topics_pathにリダイレクトされる" do
          
          sign_in user
          
          get new_topic_path
          
          expect(response).to redirect_to topics_path
        end
      end
    end
    
  end
  
  
  describe "create" do
    
      
    context "ログイン済みのユーザーの時" do
      
      let(:user) {FactoryBot.create(:user)}
      
      context "有効な属性の時" do
        
        it "topicを投稿できる" do
          
          topic_params = FactoryBot.attributes_for(:topic)
          sign_in user
          
          expect { post topics_path, params: {topic: topic_params}}.to change(user.topics, :count).by(1)
        end
      end
      
      context "無効な属性の時" do
        
        it "topicを投稿できない" do
          
          topic_params = FactoryBot.attributes_for(:topic, :invalid)
          sign_in user
          
          expect { post topics_path, params: {topic: topic_params}}.to_not change(user.topics, :count)
        end
      end
      
    end
    
    context "ログイン済みでないユーザーの時" do
      
      it "302レスポンスを返す" do
        
        topic_params = FactoryBot.attributes_for(:topic)
        
        post topics_path, params: {topic: topic_params}
        
        expect(response).to have_http_status "302"
      end
      
      it "ログイン画面にリダイレクトされる" do
        
        topic_params = FactoryBot.attributes_for(:topic)
        
        post topics_path, params: {topic: topic_params}
        
        expect(response).to redirect_to login_url
      end
    end
  end
  
  describe "destroy" do
    
    let!(:user) {FactoryBot.create(:user)}
    let!(:other_user) {FactoryBot.create(:user)}
    let!(:topic) {FactoryBot.create(:topic, user_id: user.id)}
    
    context "ログイン済みかつ現在のユーザーであるとき" do
      
      it "topicを削除できる" do
        
        sign_in user
        
        expect do
         delete topic_url topic, params: {id: topic.id}
       end.to change(Topic, :count).by(-1)
     end
     
     it "this_user_topics_user_pathにリダイレクトされる" do
       
       sign_in user
       
       delete topic_url topic, params: {id: topic.id}
       
       expect(response).to redirect_to this_user_topics_user_path
     end
   end
   
   context "ログイン済みかつ現在のユーザーでない場合" do
     
     it "他人のtopicを削除できない" do
       
       sign_in other_user
       
       expect do
         delete topic_url topic, params: {id: topic.id}
       end.to_not change(Topic, :count)
     end
     
     it "topics_pathにリダイレクトされる" do
       
       sign_in other_user
       
       delete topic_url topic, params: {id: topic.id}
       
       expect(response).to redirect_to topics_path
     end
   end
   
   context "ログインしていないユーザーの時" do
     
     it "topicを削除できない" do
       
       expect do
        delete topic_url topic, params: {id: topic.id}
       end.to_not change(Topic, :count)
     end
     
     it "ログイン画面にリダイレクトされる" do
       
       delete topic_url topic, params: {id: topic.id}
       
       expect(response).to redirect_to login_url
     end
   end
   
   
  end  
end