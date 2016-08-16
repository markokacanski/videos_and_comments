class VideosControllerTest < ActionController::TestCase
  def setup
    @user = create_user(email: "email@mail.com", password: "lol", username: "testtt")
  end


  test "should get a new video page" do
    login(@user)

    get :new
    assert_response :success
    assert_not_nil assigns(:video), "new video not assigned"
  end

  test "should create video when given a video file" do
    file = test_file(filename: 'small_video.mp4', mimetype: "video/mp4")
    login(@user)

    post :create, video: {file: file}

    assert_response :success
  end

  test "should not allow visitors to upload videos, or reach new video page" do
    get :new

    assert_redirected_to Rails.application.routes.url_helpers.sign_in_path

    file = test_file(filename: 'small_video.mp4', mimetype: "video/mp4")

    post :create, video: {file: file}

    assert_redirected_to Rails.application.routes.url_helpers.sign_in_path

  end

  test "it should show the video view page" do
    get :view, id: Video.last.id

    assert_response :success
    assert_not_nil assigns(:video), "video for viewing not assigned"
  end

  test "it should show the list of videos" do
    get :list

    assert_response :success
    assert_not_nil assigns(:videos), "videos not assigned"
  end

  teardown do
   FileUtils.rm_rf Rails.root.join('public','system', 'uploads', 'TEST').to_s
  end

private
  def test_file(args)
    test_file = Rails.root.join('test','fixtures', args.fetch(:filename, "")).to_s 
    file = Rack::Test::UploadedFile.new(test_file, args.fetch(:mimetype, ""))

    return file
  end
end