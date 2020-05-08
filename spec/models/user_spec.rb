require 'rails_helper'

RSpec.describe User, type: :model do
  
  #名、メール、パスワードがあれば有効
  it "is valid with name, email, and password" do
  
    user = User.new(name: "daisuke", email: "daisuke@example.com", password: "daisuke0000")
    
    expect(user).to be_valid
    
  end
  
  it "is invalid without a name" do
    
    user = User.new(name: nil)
    
    user.valid?
    
    expect(user.errors[:name]).to include("can't be blank")
  end
  
end
