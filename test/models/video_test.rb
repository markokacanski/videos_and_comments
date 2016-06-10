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
end
