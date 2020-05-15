require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  
  describe "new" do
    
    it "正常にレスポンスを返す" do
      get :new
      expect(response).to be_success
    end
    
    it "200レスポンスを返す" do
      get :new
      expect(response).to have_http_status "200"
    end
  end
  
  describe "show" do
    
   before do
      
      @user = FactoryBot.create(:user)
      
    end
    
    context "ログイン済みのユーザーの時" do
      
      it "正常にレスポンスを返す" do
        log_in @user
        get :show, params: {id: @user.id}
        expect(response).to be_success
      end
    end
    
    context "ログインしていないユーザーの時" do
      
      it "ログイン画面にリダイレクトされる" do
       get :show, params: {id: @user.id}
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
        
        log_in @user
        
        patch :update, params: {id: @user.id, user: user_params}
        
        expect(@user.reload.name).to eq "tester_update"
      end
    end
    
    context "ログイン済みかつ現在のユーザーでない時" do
      
      before do
        @other_user = FactoryBot.create(:user, name: "tester2")
      end
      
      it "自身以外のユーザー情報を更新できない" do
        
        user_params = FactoryBot.attributes_for(:user, name: "tester_update")
        
        log_in @user
        
        patch :update, params: {id: @other_user.id, user: user_params}
        
        expect(@other_user.reload.name).to eq "tester2"
      end
      
      it "topics_pathにリダイレクトされる" do
        
        user_params = FactoryBot.attributes_for(:user, name: "tester_update")
        
        log_in @user
        
        patch :update, params: {id: @other_user.id, user: user_params}
        
        expect(response).to redirect_to topics_path
      end
    end
    
    context "ログイン済みでないユーザーの時" do
      
      it "302レスポンスを返す" do
        
        user_params = FactoryBot.attributes_for(:user, name: "tester_update")
        
        patch :update, params: {id: @user.id, user: user_params}
        
        expect(response).to have_http_status "302"
      end
      
      it "ログイン画面にリダイレクトされる" do
        
        user_params = FactoryBot.attributes_for(:user, name: "tester_update")
        
        patch :update, params: {id: @user.id, user: user_params}
        
        expect(response).to redirect_to login_url
      end
    end
    
  end
  
  describe "destroy" do
    
    
    context "ログイン済みかつadmin_userである時" do
      
      before do
        @user = FactoryBot.create(:user, admin: true)
      end
      
      before do
        @other_user = FactoryBot.create(:user)
      end
      
      it "他のユーザーを削除できる" do
        
        @users = User.all
        
        log_in @user
        
        expect { delete :destroy, params: {id: @other_user.id}}.to change(@users, :count).by(-1)
      end
      
      it "users_showにリダイレクトされる" do
        
        @users = User.all
        
        log_in @user
        
        delete :destroy, params: {id: @other_user.id}
        
        expect(response).to redirect_to @user
      end
    end
    
    context "ログイン済みかつadmin_userでない時" do
      
      before do
        @user = FactoryBot.create(:user)
        @other_user = FactoryBot.create(:user)
      end
      
      it "他のユーザーを削除できない" do
        
        @users = User.all
        
        log_in @user
        
        expect { delete :destroy, params: {id: @other_user.id} }.to_not change(@users, :count)
      end
      
      it "topics_pathにリダイレクトされる" do
        
        log_in @user
        
        delete :destroy, params: {id: @other_user.id}
        
        expect(response).to redirect_to topics_path
      end
    end
    
    context "ログインしていない時" do
      
      before do
        @user = FactoryBot.create(:user, admin: true)
        @other_user = FactoryBot.create(:user)
      end
      
      it "ユーザーを削除できない" do
        
        @users = User.all
        
        expect { delete :destroy, params: {id: @other_user.id} }.to_not change(@users, :count)
      end
      
      it "302レスポンスを返す" do
        
        delete :destroy, params: {id: @other_user.id}
        
        expect(response).to have_http_status "302"
      end
      
      it "ログイン画面にリダイレクトされる" do
        
        delete :destroy, params: {id: @other_user.id}
        
        expect(response).to redirect_to login_url
      end
    end
  end
  

end
