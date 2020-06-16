require 'rails_helper'

RSpec.feature "Follows", type: :feature do
  
  describe "follow機能" do
    
    let!(:user) {FactoryBot.create(:user)}
    let!(:other_user) {FactoryBot.create(:user, name: "followtester")}
    let!(:topic) {FactoryBot.create(:topic, user_id: other_user.id)}
    
    context "ログイン済みの時" do
      
      scenario "フォローできる" do
        
        login(user)
        
        visit topics_path
        
        click_link "followtester"
        
        click_button "フォローする"
        
        expect(page).to have_current_path "/users/#{other_user.id}"
        expect(page).to have_content "フォロワー 1"
        expect(page).to have_content "followtester"
      end
    end
  end
  
  describe "follow解除機能" do
    
    let!(:user) {FactoryBot.create(:user)}
    let!(:other_user) {FactoryBot.create(:user, name: "followtester")}
    let!(:topic) {FactoryBot.create(:topic, user_id: other_user.id)}
    let!(:follow) {FactoryBot.create(:follow, followed_id: other_user.id, follower_id: user.id)}
    
    context "ログイン済みの時" do
      
      scenario "フォロー解除できる" do
        
        login(user)
        
        visit topics_path
        
        click_link "followtester"
        
        click_button "フォロー中"
        
        expect(page).to have_current_path "/users/#{other_user.id}"
        expect(page).to have_content "フォロワー 0"
        expect(page).to have_content "followtester"
      end
    end
  end
  
end
