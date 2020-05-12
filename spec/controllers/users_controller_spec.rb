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
  

end
