require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "Example User", email: "user@example.com")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "   "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "   "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "email validation should accept valid email addresses" do
    valid_addresses = %w[ user@example.com USER@example.com USER@EXAMPLE.cn
                          1234@qq.com USER_name@example.COM.cn ]
    valid_addresses.each do |address|
      @user.email = address
      assert @user.valid?, "#{address} should be valid"
    end
  end

  test "email validation should reject invalid email addresses" do
    invlid_addresses = %w[  foo+bar@example.com +user@example.com
                            user@example,com user_at_example.com user@example.
                            user@example..com ]
    invlid_addresses.each do |address|
      @user.email = address
      assert_not @user.valid?, "#{address} should not be valid"
    end
  end

end
