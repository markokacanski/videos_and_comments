class UsersControllerTest < ActionController::TestCase

  def setup
    @user = User.new

    @user.email = "onetwo@email.org"
    @user.password = "secret"
    @user.username = "testuser"

    @user.save
  end

  def login(user)
    session[:user_id] = user.id
  end

  test "good login" do
    post :login, email: @user.email, password: "secret"
    
    assert_redirected_to :video_list
    assert @controller.current_user == @user, "user should be logged in" 
  end

  test "bad login" do
    post :login, email: @user.email, password: "bad password"

    assert_redirected_to :sign_in
    refute @controller.current_user == @user, "user should not be able to log in with wrong password"
  end

  test "logout" do
    session[:user_id] = "test"

    get :logout

    assert_redirected_to :sign_in   
    refute session[:user_id], "user id should be unset"
  end

  test "Sign in" do
    get :sign_in
    assert_response :success
    assert assigns(:user)
  end

  test "Profile page" do
    get :profile, username: @user.username

    assert_not_nil assigns(:user), "user should be available to the view"
    
    assert (assigns(:user) == @user), "data available to the view should match the requested user"
  end

  test "Edit profile page" do
    login(@user)
    get :edit_profile

    assert_not_nil assigns(:user), "user should be available to the view"
    
    assert (assigns(:user) == @user), "data available to the view should match the logged in user"
  end

  test "Save profile" do
    old_data = @user
    login(@user)

    post :save_profile, email: "different_email", username: "different username", password: "new_secret"

    new_data = User.find(@user.id)

    assert_redirected_to :profile, username: new_data.username

    assert  new_data.email != old_data.email, "email not changed after saving edited profile"
    assert  new_data.username != old_data.username, "username not changed after saving edited profile"
    assert  new_data.password_hash != old_data.password_hash, "pw hash not changed after saving edited profile"
  end

  test "Register page" do
    get :register
  end

  test "Creating a new user" do

    usernum = User.count
    post :new_user, email: "new@email.com", password: "new_password"

    assert User.count == usernum + 1, "number of users should have been increased"
  end
end