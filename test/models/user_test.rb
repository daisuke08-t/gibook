require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @user = User.create(name: "Example User", email: "user@example.com",password: "techboost29", password_confirmation: "techboost29")
  end
  
  test "should user valid" do
    assert @user.valid?
  end
  
  test "name presentは有効か？" do
    @user.name = "   "
    assert_not @user.valid?
  end
  
  test "email presentは有効か？" do
    @user.email = "   "
    assert_not @user.valid?
  end
  
  test "nameの文字数は有効か？" do
    @user.name = "a" * 16
    assert_not @user.valid?
  end
  
  test "有効なメールフォーマットである" do
    addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    addresses.each do |adress|
      @user.email = adress
      assert @user.valid? "#{adress.inspect} は有効である"
    end
  end
  
  test "有効なメールフォーマットでない" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |adress|
      @user.email = adress
      assert_not @user.valid? "#{adress.inspect} は有効でない"
    end
  end
  
  test "emailはユニークである" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email
    @user.save
    assert_not duplicate_user.valid?
  end
  
  test "password presentは有効か？" do
    @user.password = "   "
    assert_not @user.valid?
  end
  
  test "passwordの文字数は有効か？" do
    if @user.password = @user.password_confirmation = "a" * 7
      assert_not @user.valid?
      
    elsif @user.password = @user.password_confirmation = "a" * 21
      assert_not @user.valid?
    end
  end
  
end
