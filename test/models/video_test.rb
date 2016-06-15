require 'test_helper'

class VideoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @video = Video.new
  end

  test "video has a title description and view count" do  
    assert_respond_to @video, :title, "video has no title"
    assert_respond_to @video, :view_count, "video has no view count"
    assert_respond_to @video, :description, "video has no description"
  end

  test "video has a video file" do
    assert_respond_to @video, :video_file, "video has no file"
    assert (@video.video_file.kind_of? Paperclip::Attachment), "video file is not a paperclip attachment"
  end

  test "videos are valid with a proper video file" do
    file = test_file(filename: 'small_video.mp4', mimetype: "video/mp4")

    @video.video_file = file
    assert @video.valid?, "video with a proper video file should be valid"
  end

  test "videos are not valid without a proper video file" do
    file = test_file(filename: 'small_image.jpg', mimetype: "image/jpeg")

    @video.video_file = file
    refute @video.valid?, "video without a proper video file should not be valid"
  end

  test "video has a thumbnail" do
    name = false
    style_format = false

    @video.video_file.styles.values.each do |style|
      #note that style name and format are kept as symbols
      if style.name == :thumbnail
        name = true
        if style.format == :png
          style_format = true
        end;
      end;
    end
    
    assert name, "there is no style named thumbnail"
    if name
      assert style_format, "the thumbnail is not a .png image"
    end
  end

private
  def test_file(args)
    test_file = Rails.root.join('test','fixtures', args.fetch(:filename, "")).to_s 
    file = Rack::Test::UploadedFile.new(test_file, args.fetch(:mimetype, ""))

    return file
  end
end
