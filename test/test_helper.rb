require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

# Use minitest-reporters to create customizable Minitest output formats
require "minitest/reporters"
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new


class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  include ApplicationHelper
  include SessionsHelper

  def is_logged_in?
    !session[:user_id].nil?
  end
end

class ActionDispatch::IntegrationTest

  def log_in_as(user, password: "foobar", remember_me: '1')
    post login_path, params: { session: { email: user.email,
                               password: password,
                               remember_me: remember_me} }
  end
end
