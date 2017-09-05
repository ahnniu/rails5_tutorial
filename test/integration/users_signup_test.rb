require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "invalid signup infomation" do
    get signup_path
    assert_no_difference 'User.count' do
      post signup_path, params: { user: { name: "",
                                 email: "user@invalid",
                                 passpword: "foo",
                                 password_confirmation: "bar" }}
    end

    assert_template 'users/new'
    # Should have some error messages
    assert_select "div#error_explanation"
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post signup_path, params: { user: { name: "Test User",
                                  email: "email@test.com",
                                  password: "123456"}}
    end
    follow_redirect!
    assert_template 'users/show'
    assert_select "div.alert-success"
    assert_not flash.empty?
  end
end
