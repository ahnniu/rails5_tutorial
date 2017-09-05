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
                                 passowrd_confirmation: "bar" }}
    end

    assert_template 'users/new'
    # Should have some error messages
    assert_select "div#error_explanation"
  end
end
