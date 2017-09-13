require 'test_helper'

class SessionHelperTest < ActionView::TestCase

  def setup
    @user = users(:foo)
  end

  test "current user should return nil without login or remember" do
    assert_nil current_user
  end

  test "current user should return right user when login" do
    log_in(@user)
    assert_equal @user, current_user
  end

  test "current user should return right user when remembering with empty session" do
    remember(@user)
    assert_equal @user, current_user
    assert is_logged_in?
  end

  test "current user should return nil when remembering with a wrong token" do
    remember(@user)
    @user.update_attribute(:remember_digest, User.digest(User.new_token))
    assert_nil current_user
    assert_not is_logged_in?
  end


end