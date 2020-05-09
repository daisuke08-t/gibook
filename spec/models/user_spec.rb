require 'rails_helper'

RSpec.describe User, type: :model do
  
  before do
    @user = FactoryBot.build(:user)
  end
  
  
  it "有効なファクトリを持つこと" do
    
    expect(FactoryBot.build(:user)).to be_valid
    
  end
  
  
  it "name, email, passwordがあれば有効" do
    
    expect(@user).to be_valid
    
  end

  it "nameがなければ無効" do
    
    @user.name = nil
    
    @user.valid?
    
    expect(@user.errors[:name]).to include("can't be blank")
  end
  
  it "nameの文字列が16文字以上は無効" do
    @user.name = "a" * 16
    @user.valid?
    
    expect(@user.errors[:name]).to include("is too long (maximum is 15 characters)")
  end
  
  it "emailが空の場合は無効" do
    
    @user.email = nil
    @user.valid?
    expect(@user.errors[:email]).to include("can't be blank") 
  end
  
  
  it "重複したメールアドレスなら無効" do
    
    
    FactoryBot.create(:user, email: "tester7@example.com")
    
    @user.valid?
    expect(@user).to be_invalid
  end
  
  describe "emailのフォーマット" do
    
    context "有効なメールフォーマットの時" do
      
      addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
      
      it "有効" do
        addresses.each do |adress|
         @user.email = adress
          expect(@user).to be_valid
        end
      end
    end
    
    context "無効なメールフォーマットの時" do
      
      invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
      
      it "無効" do
        invalid_addresses.each do |adress|
         @user.email = adress
         expect(@user).to be_invalid
        end
      end
    end
    
  end
  
  
  it "passwordが空の場合は無効" do
    
    @user.password = nil
    @user.valid?
    expect(@user.errors[:password]).to include("can't be blank")
  end
  
  describe "passwordの長さ" do
    
    context "passwordの文字列が８文字の時" do
      
      it "有効" do
        @user.password = @user.password_confirmation = "a" * 4 + "0" * 4
        
        expect(@user).to be_valid
      end
    end
    
    context "passwordの文字列が32文字は有効" do
      
      it "有効" do
        @user.password = @user.password_confirmation = "a" * 16 + "0" * 16
        
        expect(@user).to be_valid
      end
    end
    
    context "passwordの文字列が７文字以下の時は無効" do
      
      it "無効" do
        @user.password = @user.password_confirmation = "a" * 7
        @user.valid?
        
        expect(@user.errors[:password]).to include("is too short (minimum is 8 characters)")
      end
    end
    
    context "passwordが３３文字以上のときは無効" do
      
      it "無効" do
        @user.password = @user.password_confirmation = "a" * 33
        @user.valid?
        
        expect(@user.errors[:password]).to include("is too long (maximum is 32 characters)")
      end
    end
  end
  
  describe "passwordのフォーマット" do
    
    context "有効なフォーマット（半角英数字を１文字以上使用）の時" do
      
      passwords = ["aaa00000", "0000aaaaaa"]
      
      it "有効" do
        passwords.each do |password|
          @user.password = @user.password_confirmation = password
          expect(@user).to be_valid
        end
      end
    end
    
    context "無効なフォーマットの時" do
      
      passwords = ["aaaaaaaa", "00000000"]
      
      it "無効" do
        passwords.each do |password|
          @user.password = @user.password_confirmation = password
          expect(@user).to be_invalid
        end
      end
    end
  end
  
end
