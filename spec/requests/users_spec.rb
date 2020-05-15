require 'rails_helper'

RSpec.describe "Users", type: :request do
  
  describe "show" do
    
   before do
      
      @user = FactoryBot.create(:user)
      
    end
    
    context "ログイン済みのユーザーの時" do
      
      it "正常にレスポンスを返す" do
        sign_in(@user)
        get user_path @user
        expect(response).to have_http_status "302"
      end
    end
    
    context "ログインしていないユーザーの時" do
      
      it "ログイン画面にリダイレクトされる" do
        get user_path @user
        expect(response).to redirect_to login_url
      end
    end
  end
  
  
  describe "update" do
    
    before do
      @user = FactoryBot.create(:user)
    end
    
    context "ログイン済みかつ現在のユーザーの時" do
      
      it "ユーザー情報を更新できる" do
        
        user_params = FactoryBot.attributes_for(:user, name: "tester_update")
        
        sign_in(@user)
        
        expect do
          patch user_url @user, params: { user: user_params }
        end.to change { User.find(@user.id).name}.from('tester').to('tester_update')
      end
    end
    
    context "ログイン済みかつ現在のユーザーでない時" do
      
      before do
        @other_user = FactoryBot.create(:user, name: "tester2")
      end
      
      it "自身以外のユーザー情報を更新できない" do
        
        user_params = FactoryBot.attributes_for(:user, name: "tester_update")
        
        sign_in(@user)
        
        patch user_path @other_user, params: {user: user_params}
        
        expect(@other_user.reload.name).to eq "tester2"
      end
      
      it "topics_pathにリダイレクトされる" do
        
        user_params = FactoryBot.attributes_for(:user, name: "tester_update")
        
        sign_in(@user)
        
        patch user_path @other_user, params: { user: user_params }
        
        expect(response).to redirect_to topics_path
      end
    end
    
    context "ログイン済みでないユーザーの時" do
      
      it "302レスポンスを返す" do
        
        user_params = FactoryBot.attributes_for(:user, name: "tester_update")
        
        patch user_path @user, params: {user: user_params}
        
        expect(response).to have_http_status "302"
      end
      
      it "ログイン画面にリダイレクトされる" do
        
        user_params = FactoryBot.attributes_for(:user, name: "tester_update")
        
        patch user_path @user, params: {user: user_params}
        
        expect(response).to redirect_to login_url
      end
    end
    
  end
  
end