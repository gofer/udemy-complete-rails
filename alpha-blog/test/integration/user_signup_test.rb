require "test_helper"

class UserSignupTest < ActionDispatch::IntegrationTest
  def setup
    
  end

  test "a new user can sign up" do
    get signup_path
    assert_response :success
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { username: "John Doe", email: "johndoe@example.com", password: "password" } }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
  end
end
