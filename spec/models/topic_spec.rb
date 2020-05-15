require 'rails_helper'

RSpec.describe Topic, type: :model do
  
  let(:user) { FactoryBot.create(:user) }
  
  let(:topic) { FactoryBot.create(:topic) }
  
  it "user_id, titleがあれば有効" do
    
    expect(topic).to be_valid
  end
  
  it "user_idがなければ無効" do
    
    topic.user_id = nil
    
    topic.valid?
    
    expect(topic.errors[:user_id]).to include("can't be blank")
    
  end
  
  it "titleが無ければ無効" do
    
    topic.title = nil
    
    topic.valid?
    
    expect(topic.errors[:title]).to include("can't be blank")
    
  end
  
end
