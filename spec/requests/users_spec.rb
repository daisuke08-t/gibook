require 'rails_helper'

RSpec.describe "Users", type: :request do
  
  describe "show" do
    
    let(:user) { FactoryBot.create(:user) }
    
    context "ログイン済みのユーザーの時" do
      
      it "正常にレスポンスを返す" do
        sign_in(user)
        get user_path user
        expect(response).to have_http_status "302"
      end
    end
    
    context "ログインしていないユーザーの時" do
      
      it "ログイン画面にリダイレクトされる" do
        get user_path user
        expect(response).to redirect_to login_url
      end
    end
  end
  
  
  describe "update" do
    
    let(:user) { FactoryBot.create(:user) }
    
    #context "ログイン済みかつ現在のユーザーの時" do       #コントローラーで代用
      
     # it "ユーザー情報を更新できる" do
        
      #  user_params = FactoryBot.attributes_for(:user, name: "tester_update")
        
       # sign_in(@user)
        
        #expect do
         # patch user_url @user, params: { user: user_params }
        #end.to change { User.find(@user.id).name}.from('tester').to('tester_update')
      #end
    #end
    
    context "ログイン済みかつ現在のユーザーでない時" do
      
      let(:other_user) { FactoryBot.create(:user, name: "tester2") }
        let(:user_params) { FactoryBot.attributes_for(:user, name: "tester_update") }
      
      it "自身以外のユーザー情報を更新できない" do
        
        
        sign_in(user)
        
        patch user_path other_user, params: {user: user_params}
        
        expect(other_user.reload.name).to eq "tester2"
      end
      
      #it "topics_pathにリダイレクトされる" do           #コントローラーで代用
        
       # user_params = FactoryBot.attributes_for(:user, name: "tester_update")
        
        #sign_in(@user)
        
        #patch user_path @other_user, params: { user: user_params }
        
        #expect(response).to redirect_to topics_path
      #end
    end
    
    context "ログイン済みでないユーザーの時" do
      
      let(:user_params) { FactoryBot.attributes_for(:user, name: "tester_update") }
      
      
      it "302レスポンスを返す" do
        
        
        patch user_path user, params: {user: user_params}
        
        expect(response).to have_http_status "302"
      end
      
      it "ログイン画面にリダイレクトされる" do
        
        patch user_path user, params: {user: user_params}
        
        expect(response).to redirect_to login_url
      end
    end
    
  end
  
end