require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @user = User.new(name: "Example User", email: "user@example.com",password: "techboost29", password_confirmation: "techboost29")
  end
  
  test "should user valid" do
    assert @user.valid?
  end
end
