require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "User has a title, username, description, email and password hash" do

    user = User.new

    assert_respond_to user, :title, "User does not have a title"
    assert_respond_to user, :username, "User does not haave a username"
    assert_respond_to user, :description, "User does not have a description"
    assert_respond_to user, :email, "User does not have a email"
    assert_respond_to user, :password_hash, "User does not have a password_hash"
  end

  test "User password hashing" do
    user = User.new

    assert_respond_to user, :password=, "there is no password set method"
    assert_respond_to user, :password_match, "there is no password match method"

    test_pw = "VideosNComments"

    user.password = test_pw

    assert user.password_hash, "password not stored"
    refute user.password_hash == test_pw, "Passwords must not be stored as plain text"
    assert user.password_match(test_pw), "Password match must perform password check"
  end
end
