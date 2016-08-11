class UsersController < ApplicationController
  def login
    user = User.find_by email: params[:email]

    if user
      if user.password_match(params[:password])
        session[:user_id] = user.id
        redirect_to :video_list
      else
        redirect_to :sign_in
      end
    else
      redirect_to :sign_in
    end
  end

  def sign_in
    @user = User.new
  end

  def logout
    session[:user_id] = nil
    redirect_to :sign_in
  end

  def profile
    unless params[:username].nil?
      @user = User.find_by(username: params[:username])
    else
      @user = current_user
    end
  end

  def edit_profile
    users_only
    @user = current_user
  end

  def save_profile
    users_only # limit to logged in users
    @user = current_user


    @user.avatar = params[:avatar] unless params[:avatar].nil?
    @user.cover = params[:cover] unless params[:cover].nil?
    @user.email = params[:email] unless params[:email].nil?
    @user.title = params[:title] unless params[:title].nil?
    @user.description = params[:description] unless params[:description].nil?
    @user.username = params[:username] unless params[:username].nil?
    @user.password = params[:password] unless params[:password].nil?

    @user.save

    redirect_to :profile
  end

  def register
    # just shows the registration page :)
  end

  def new_user
    u = User.new

    u.email = params[:email]
    u.password = params[:password]

    u.save

    session[:user_id] = u.id # manual log in

    redirect_to :profile
  end

end