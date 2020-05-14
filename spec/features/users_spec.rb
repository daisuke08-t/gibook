require 'rails_helper'

RSpec.feature "Users", type: :feature do
  
  describe "アカウント登録機能" do
    
    before do
      @user = FactoryBot.build(:user)
    end
    
    context "有効な属性でアカウント登録" do
      
      scenario "登録成功" do
        
        visit root_path
        
        click_link "sign up"
        
        fill_in "Name", with: @user.name
        
        fill_in "Email", with: @user.email
        
        fill_in "Password", with: @user.password
        
        fill_in "Password confirmation", with: @user.password
        
        click_button "登録"
        
        expect(page).to have_content "登録が完了しました"
        expect(page).to have_content "Time Line"
        expect(page).to have_content "Search Books"
      end
    end
    
    context "無効な属性でアカウント登録" do
      
      scenario "登録失敗" do
        
        visit root_path
        
        click_link "sign up"
        
        fill_in "Name", with: " "
        
        fill_in "Email", with: " "
        
        fill_in "Password", with: " "
        
        fill_in "Password confirmation", with: " "
        
        click_button "登録"
        
        expect(page).to have_content "登録に失敗しました"
      end
    end
  end
  
  describe "ログイン、ログアウト機能" do
    
    context "有効な属性でログインする" do
      
      scenario "ログイン成功" do
        
        @user = FactoryBot.create(:user)
        
        visit root_path
        
        click_link "log in"
        
        fill_in "Email", with: @user.email
        
        fill_in "Password", with: @user.password
        
        click_button "ログイン"
        
        expect(page).to have_content "ログインしました"
      end
    end
    
    context "無効な属性でログインする" do
      
      scenario "ログイン失敗" do
        
        @user = FactoryBot.create(:user)
        
        visit root_path
        
        click_link "log in"
        
        fill_in "Email", with: @user.email
        
        fill_in "Password", with: "000000test"
        
        click_button "ログイン"
        
        expect(page).to have_content "ログインに失敗しました"
      end
    end
    
    scenario "ログアウト" do
      
      @user = FactoryBot.create(:user)
      
      login(@user)
      
      click_link "Log out"
      
      expect(page).to have_content "ログアウトしました"
    end
  end
  
  describe "ユーザー情報編集機能" do
    
    before do
      @user = FactoryBot.create(:user)
      @other_user = FactoryBot.create(:user)
    end
    
    context "有効なユーザーの時" do
      
      context "有効な属性の時" do
        
        scenario "編集成功" do
          
          login(@user) 
          
          visit topics_path
          
          click_link "Mypage"
          
          click_link "ユーザーの編集"
          
          fill_in "Name", with: "edittester"
          
          fill_in "Email", with: "edittester@example.com"
          
          attach_file "Icon", "app/assets/images/icon/test.jpg"
          
          fill_in "Content", with: "はじめまして"
          
          click_button "更新"
          
          expect(page).to have_current_path "/users/#{@user.id}"
          expect(page).to have_content "ユーザー情報を更新しました"
          expect(page).to have_content "edittester"
          expect(page).to have_content "はじめまして"
          
        end
      end
      
      context "無効な属性の時" do
        
        scenario "編集失敗" do
          
          login(@user) 
          
          visit topics_path
          
          click_link "Mypage"
          
          click_link "ユーザーの編集"
          
          fill_in "Name", with: "   "#nameがない
          
          fill_in "Email", with: "edittesterexample.com" #emailが正しくない
          
          attach_file "Icon", "app/assets/images/icon/test.jpg"
          
          fill_in "Content", with: "はじめまして"
          
          click_button "更新"
          
          expect(page).to have_current_path "/users/#{@user.id}"
          expect(page).to have_content "Name can't be blank"
          expect(page).to have_content "Email is invalid"
        end
      end
    end
    
    context "無効なユーザーの時" do
      
      scenario "topics_pathにリダイレクトされる" do
        
        login(@user)
        
        visit "/users/#{@other_user.id}/edit"
        
        expect(page).to have_current_path topics_path
      end
    end
  end
  
end
