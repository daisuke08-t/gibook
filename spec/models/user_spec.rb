require 'rails_helper'

RSpec.describe User, type: :model do
  
  #名、メール、パスワードがあれば有効
  it "is valid with name, email, and password" do
  
    user = User.new(name: "daisuke", email: "daisuke@example.com", password: "daisuke0000")
    
    expect(user).to be_valid
    
  end
  
  #名前がない場合は無効
  it "is invalid without a name" do
    
    user = User.new(name: nil)
    
    user.valid?
    
    expect(user.errors[:name]).to include("can't be blank")
  end
  
  it "nameの文字列が16文字以上は無効" do
    
    user = User.new
    user.name = "a" * 16
    user.valid?
    
    expect(user.errors[:name]).to include("is too long (maximum is 15 characters)")
  end
  
  it "emailが空の場合は無効" do
    
    user = User.new(email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank") 
  end
  
  #重複したメールアドレスなら無効
  it "is invalid with a duplicate email adress" do
    
    User.create(name: "taniguchi", email: "daisuke@example.com", password: "daisuke0000")
    
    user = User.new(name: "daisuke", email: "daisuke@example.com", password: "daisuke0000")
    
    user.valid?
    
    expect(user.errors[:email]).to include("has already been taken")
  end
  
  #it "有効なメールフォーマットである" do
    
   # user = User.new
    
    #addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    
    #addresses.each do |adress|
     # user.email = adress
      #expect(user.email).to be_valid
    #end
  #end
  
  #it "無効なメールフォーマットである" do
    
   # user = User.new
    
    #invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
    
    #invalid_addresses.each do |adress|
     # user.email = adress
      #expect(user.email).to be_invalid
    #end
  #end
  
  
  it "passwordが空の場合は無効" do
    
    user = User.new(password: nil)
    user.valid?
    expect(user.errors[:password]).to include("can't be blank")
  end
  
  it "passwordの文字列が7文字以下33文字以上は無効" do
    
    user = User.new
    
    if user.password = user.password_confirmation = "a" * 7
      user.valid?
      expect(user.errors[:password]).to include("is too short (minimum is 8 characters)")
    end
    
    if user.password = user.password_confirmation = "a" * 33
      user.valid?
      expect(user.errors[:password]).to include("is too long (maximum is 32 characters)")
    end
  end
  
end
