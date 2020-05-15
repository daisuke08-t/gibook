require 'rails_helper'

RSpec.describe Follow, type: :model do
  
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user, name: "tester2") }
  let(:follow) { FactoryBot.create(:follow, follower_id: user.id, followed_id: other_user.id) }
  
  it "followed_id, follower_idがあれば有効" do
    
    expect(follow).to be_valid 
    
  end
  
  it "followed_idが無ければ無効" do
    
    follow.followed_id = nil
    
    follow.valid?
    
    expect(follow).to be_invalid
    
  end
  
  it "follower_idが無ければ無効" do
    
    follow.follower_id = nil
    
    follow.valid?
    
    expect(follow).to be_invalid
    
  end
  
end
