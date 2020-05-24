require 'rails_helper'

RSpec.describe "Users", type: :request do
  
  describe "new" do
    
    it "正常にレスポンスを返す" do
      get new_user_path
      expect(response).to be_success
    end
    
    it "200レスポンスを返す" do
      get new_user_path
      expect(response).to have_http_status "200"
    end
  end
  
  describe "show" do
    
    let(:user) { FactoryBot.create(:user) }
    
    context "ログイン済みのユーザーの時" do
      
      it "正常にレスポンスを返す" do
        
        sign_in(user)
        
        get user_path user
        expect(response).to have_http_status "200"
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
    
    context "ログイン済みかつ現在のユーザーの時" do
      
     it "ユーザー情報を更新できる" do
       
       sign_in(user)
        
       user_params = FactoryBot.attributes_for(:user, name: "tester_update")
        
        
        expect do
         patch user_url user, params: { user: user_params }
        end.to change { User.find(user.id).name}.from('tester').to('tester_update')
      end
    end
    
    context "ログイン済みかつ現在のユーザーでない時" do
      
      let(:other_user) { FactoryBot.create(:user, name: "tester2") }
        let(:user_params) { FactoryBot.attributes_for(:user, name: "tester_update") }
      
      it "自身以外のユーザー情報を更新できない" do
        
        sign_in(user)
        
        patch user_path other_user, params: {user: user_params}
        
        expect(other_user.reload.name).to eq "tester2"
      end
      
      it "topics_pathにリダイレクトされる" do  
        
        sign_in(user)
        
        user_params = FactoryBot.attributes_for(:user, name: "tester_update")
        
        
        patch user_path other_user, params: { user: user_params }
        
        expect(response).to redirect_to topics_path
      end
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
  
  describe "destroy" do
    
    let(:user) {FactoryBot.create :user, admin: true}
    let(:other_user) { FactoryBot.create :user, admin: false }
    
    context "admin_userでログインしている時" do
      
      
      it "他のユーザーを削除できる" do
        
        sign_in(user)
        
        
        expect do
          delete user_url other_user,  params: {id: other_user.id}
        end.to change(User, :count).by(-1)
      end
      
      it "showにリダイレクトされる" do
        
        sign_in(user)
        
        delete user_url other_user, params: {id: other_user.id}
        
        expect(response).to redirect_to current_user
      end
    end
    
    context "admin_userでないとき" do
      
      
      it "他のユーザーを削除できない" do
        
        sign_in(other_user)
        
        
        expect do
         delete user_url user, params: {id: user.id}
       end.to_not change(User, :count)
       
     end
     
     it "topics_pathにリダイレクトされる" do
       
       sign_in(other_user)
       
       delete user_url user, params: {id: user.id}
       
       expect(response).to redirect_to topics_path
     end
     
   end
    
  end
  
end