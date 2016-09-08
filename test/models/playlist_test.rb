require 'test_helper'

class PlaylistTest < ActiveSupport::TestCase

	def setup
		@playlist = Playlist.new
	end
 
	test "playlist has many videos" do
		assert_respond_to @playlist, :videos, "Playlist must have videos"
	end

	test "playlist has many playlist entries" do
		assert_respond_to @playlist, :playlist_entries, "Playlist must have playlist_entries"
	end


	test "playlist has ordered videos" do
		v1 = Video.new
		v2 = Video.new
		v3 = Video.new

		@playlist.add_video(v1)
		@playlist.add_video(v2)
		@playlist.add_video(v3)

		assert @playlist.videos[0] == v1, "video 1 not ordered correctly"
		assert @playlist.videos[1] == v2, "video 2 not ordered correctly"
		assert @playlist.videos[2] == v3, "video 3 not ordered correctly"
	end
end
