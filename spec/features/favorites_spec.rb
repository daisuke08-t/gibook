require 'rails_helper'

RSpec.feature "Favorites", type: :feature do
  
  describe "favorite機能" do
    
    let!(:user) {FactoryBot.create(:user)}
    let!(:other_user) {FactoryBot.create(:user)}
    let!(:topic) {FactoryBot.create(:topic, user_id: other_user.id)}
    
    context "ログイン済みの時" do
      
      scenario "お気に入りできる" do
        
        login(user)
        
        visit topics_path
        
        find('.favorite-url').click
        
        expect(page).to have_current_path "/topics"
        expect(page).to have_content "投稿をお気に入りしました"
      end
    end
  end
  
  
  describe "favorite解除機能" do
    
    let!(:user) {FactoryBot.create(:user)}
    let!(:other_user) {FactoryBot.create(:user)}
    let!(:topic) {FactoryBot.create(:topic, user_id: other_user.id)}
    let!(:favorite) {FactoryBot.create(:favorite, user_id: user.id, topic_id: topic.id)}
    
    context "ログイン済みの時" do
      
      scenario "お気に入り解除できる" do
        
        login(user)
        
        visit topics_path
        
        find('.favorite-url').click
        
        expect(page).to have_current_path "/topics"
        expect(page).to have_content "お気に入りを解除しました"
      end
    end
  end
  
  
end
