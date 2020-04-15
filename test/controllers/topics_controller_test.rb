require 'test_helper'

class TopicsControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = User.new(name: "Example User", email: "user@example.com",password: "techboost29", password_confirmation: "techboost29")
  end
  
  test "should get new" do
    log_in @user
    get new_topic_path
    assert_response :success
  end

end
