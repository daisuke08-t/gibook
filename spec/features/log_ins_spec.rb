require 'rails_helper'

RSpec.feature "LogIns", type: :feature do
  
  scenario "有効な属性でログインする" do
    
    @user = FactoryBot.create(:user)
    
    visit root_path
    
    click_link "log in"
    
    fill_in "Email", with: @user.email
    
    fill_in "Password", with: @user.password
    
    click_button "ログイン"
    
    expect(page).to have_content "ログインしました"
  end
  
  scenario "無効な属性でログインする" do
    
    @user = FactoryBot.create(:user)
    
    visit root_path
    
    click_link "log in"
    
    fill_in "Email", with: @user.email
    
    fill_in "Password", with: "000000test"
    
    click_button "ログイン"
    
    expect(page).to have_content "ログインに失敗しました"
  end
end
