require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = User.new
  end

  test "User has a title, username, description, email and password hash" do

    

    assert_respond_to @user, :title, "User does not have a title"
    assert_respond_to @user, :username, "User does not haave a username"
    assert_respond_to @user, :description, "User does not have a description"
    assert_respond_to @user, :email, "User does not have a email"
    assert_respond_to @user, :password_hash, "User does not have a password_hash"
  end

  test "User password hashing" do
    

    assert_respond_to @user, :password=, "there is no password set method"
    assert_respond_to @user, :password_match, "there is no password match method"

    test_pw = "VideosNComments"

    @user.password = test_pw

    assert @user.password_hash, "password not stored"
    refute @user.password_hash == test_pw, "Passwords must not be stored as plain text"
    assert @user.password_match(test_pw), "Password match must perform password check"
  end

  test "User has an avatar and profile cover pic" do
    assert_respond_to @user, :avatar, "avatar has no file"
    assert (@user.avatar.kind_of? Paperclip::Attachment), "avatar file is not a paperclip attachment"

    assert_respond_to @user, :cover, "cover has no file"
    assert (@user.cover.kind_of? Paperclip::Attachment), "avatar file is not a paperclip attachment"
  end
end
