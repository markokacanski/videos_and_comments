require 'test_helper'

class VideoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "videos have a title description and view count" do
    vid = Video.new

    assert_respond_to vid, :title, "video has no title"
    assert_respond_to vid, :view_count, "video has no view count"
    assert_respond_to vid, :description, "video has no description"
  end
end
