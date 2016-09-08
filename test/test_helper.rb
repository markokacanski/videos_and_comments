ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  def login(user)
    session[:user_id] = user.id
  end

  def create_user(args)
  	user = User.new

    user.email = args[:email]
    user.password = args[:password]
    user.username = args[:username]

    user.save

    return user
  end
end
