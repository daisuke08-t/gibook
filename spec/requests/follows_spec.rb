require 'rails_helper'

RSpec.describe "Follows", type: :request do
  
  describe "create" do
    
    let!(:user) {FactoryBot.create(:user)}
    let!(:other_user) {FactoryBot.create(:user)}
    
    context "ログイン済みの時" do
      
      
      it "followできる" do
        
        sign_in user
        
        expect do
          post follows_path, params: {followed_id: other_user.id}
        end.to change(Follow, :count).by(1)
      end
      
      it "Mypageにリダイレクトされる" do
        
        sign_in user
        
        post follows_path, params: {followed_id: other_user.id}
        
        expect(response).to redirect_to user_path(other_user)
      end
      
      context "ログインしていないとき" do
        
        it "followできない" do
          
          expect do
            post follows_path, params: {followed_id: other_user.id}
          end.to_not change(Follow, :count)
        end
        
        it "ログイン画面にリダイレクトされる" do
          
          post follows_path, params: {followed_id: other_user.id}
          
          expect(response).to redirect_to login_url
        end
      end
    end
    
    
  end
  
  describe "destroy" do
    
    let!(:user) {FactoryBot.create(:user)}
    let!(:other_user) {FactoryBot.create(:user)}
    let!(:follow) {FactoryBot.create(:follow, followed_id: other_user.id, follower_id: user.id)}
    
    context "ログイン済みの時" do
      
      it "follow解除できる" do
        
        sign_in user
        
        expect do
          delete follow_path follow, params: {id: other_user.id}
        end.to change(Follow, :count).by(-1)
      end
      
      it "Mypageにリダイレクトされる" do
        
        sign_in user
        
        delete follow_path follow, params: {id: other_user.id}
        
        expect(response).to redirect_to user_path(other_user)
      end
    end
    
    context "ログイン済みでないとき" do
      
      it "follow解除できない" do
        
        expect do
          delete follow_path follow, params: {id: other_user.id}
        end.to_not change(Follow, :count)
      end
      
      it "ログイン画面にリダイレクトされる" do
        
        delete follow_path follow, params: {id: other_user.id}
        
        expect(response).to redirect_to login_url
      end
    end
  end
  
end