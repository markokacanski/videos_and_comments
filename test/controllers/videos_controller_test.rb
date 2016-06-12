class VideosControllerTest < ActionController::TestCase
  test "should get a new video page" do
    get :new
    assert_response :success
    assert_not_nil assigns(:video), "new video not assigned"
  end

  test "should create video when given a video file" do
    file = test_file(filename: 'small_video.mp4', mimetype: "video/mp4")

    post :create, video: {file: file}

    assert_response :success
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