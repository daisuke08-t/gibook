require 'rails_helper'

RSpec.describe "Example", type: :request do
  
  describe "new" do
    
    it "正常にレスポンスを返す" do
      
      get login_path
      
      expect(response).to be_success
    end
    
    it "200レスポンスを返す" do
      
      get login_path
      
      expect(response).to have_http_status "200"
    end
  end
  
  describe "create" do
    
    
    context "有効なユーザーの時" do
      
      let!(:user) {FactoryBot.create(:user)}
      
      it "loginできる(topics_pathにリダイレクトされる)" do
        
        post login_path, params: {session: {email: user.email} }, params: {session: {password: user.password}}
        
        expect(response).to redirect_to topics_path
      end
    end
    
    context "無効なユーザーの時" do
      
      let!(:user) {FactoryBot.build(:user)}
      
      it "loginできない(login_pathにレンダリングされる)" do
        
        post login_path, params: {session: {email: user.email} }, params: {session: {password: user.password}}
        
        expect(response.body).to include 'ログインに失敗しました'
      end
    end
  end
  
  describe "destroy" do
    
    let!(:user) {FactoryBot.create(:user)}
    
    context "ログイン済みの時" do
      
      it "ログアウトできる" do
        
        sign_in user
        
        delete logout_path
        
        expect(response).to redirect_to root_url
      end
    end
    
    context "ログイン済みで無いとき" do
      
      it "ログアウトできない(login_pathにリダイレクトされる)" do
        delete logout_path
        
        expect(response).to redirect_to login_path
      end
    end
  end
  
end