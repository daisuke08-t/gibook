require 'rails_helper'

RSpec.feature "Topics", type: :feature do
  
  describe "投稿機能" do
    
    let!(:user) {FactoryBot.create(:user)}
    let!(:book) {FactoryBot.create(:book, user_id: user.id)}
    
    context "有効な属性で投稿" do
      
      scenario "投稿成功" do
        
        login(user)
        
        visit topics_path
        
        click_link "Mypage"
        
        click_link "My Books"
        
        click_button "書籍を紹介"
        
        fill_in "Title", with: "books"
        
        fill_in "Author", with: "author"
        
        fill_in "Content", with: "test"
        
        click_button "投稿"
        
        expect(page).to have_current_path "/topics"
        expect(page).to have_content "投稿しました"
        expect(page).to have_content "Time Line"
        expect(page).to have_content "books"
        expect(page).to have_content "author"
        expect(page).to have_content "test"
        
      end
    end
    
    context "無効な属性で投稿" do
      
      scenario "投稿失敗" do
        
        login(user)
        
        visit topics_path
        
        click_link "Mypage"
        
        click_link "My Books"
        
        click_button "書籍を紹介"
        
        fill_in "Title", with: ""
        
        fill_in "Author", with: "author"
        
        fill_in "Content", with: "test"
        
        click_button "投稿"
        
        expect(page).to have_current_path "/topics"
        expect(page).to have_content "投稿に失敗しました"
        expect(page).to have_content "Title can't be blank"
        expect(page).to have_content "Introduction Books"
        
      end
    end
  end
  
end
