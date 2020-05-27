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
  
end