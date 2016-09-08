class ApplicationControllerTest < ActionController::TestCase

  test "session management" do
    user = User.first
    session[:user_id] = user.id

    assert @controller.current_user == user, "User whose id is in session, should be set as current user"
    assert @controller.logged_in? == true, "If there is an id in the session, someone is logged in"
  end
end