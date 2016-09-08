class PlaylistsControllerTest < ActionController::TestCase

	def setup
		@user = create_user(username: "marko", password: "lolol", email: "marko@mk.com")
		#make playlist
		@user.playlists.create(name: "testlist")
		@playlist = @user.playlists.find_by(name: "testlist")
	end


	test "user can create a playlist" do
		login(@user)

		post :new, name: "new playlist"

		assert @user.playlists.last == assigns(:playlist), "playlist not created"
	end

	test "non-user cannot make a playlist" do
		post :new, name: "new pl"

		assert_redirected_to Rails.application.routes.url_helpers.sign_in_path, "NON user succesfully create a playlist"
	end


	test "user can add a video to the playlist" do
		login(@user)
		
		playlist = Playlist.new
		playlist.user = @user
		playlist.name = "pln"
		playlist.save

		video = Video.new
		video.save

		post :add_video, playlist: playlist.id, video: video.id


		assert @user.playlists.find(playlist.id).videos.last == video, "video not added to the playlist"
	end

	test "user can only add videos to his own playlist" do
		post :add_video, playlist: 10, video: 11

		assert_redirected_to Rails.application.routes.url_helpers.sign_in_path, "NON user succesfully added video to a playlist"
	end

	test "user can change the video order on his playlist" do
		login(@user)

		#make two videos
		vid1 = Video.new
		vid1.save

		vid2 = Video.new
		vid2.save

		vid3 = Video.new
		vid3.save

		#take a playlist and add two vids
		@playlist.add_video(vid1)
		@playlist.add_video(vid2)
		@playlist.add_video(vid3)

		# change the position via post to URL
		post :change_video_place, playlist: @playlist.id, video: vid2.id, new_place: 0

		assert @playlist.videos[0] == vid2, "video 2 should be in the first place"
		assert @playlist.videos[1] == vid1, "video 1 should be in the second place"
		assert @playlist.videos[2] == vid3, "video 3 should be in the third place"


		# it's important for playlist entries to maintain sequence as intuitive as possible
		# after re-arranging. if we allowed for sequence to become the same for two entries
		# it might still work most of the time, but sometimes cause difficult to recreate errors
		# and summon demons from the hell dimension

		assert @playlist.playlist_entries[0].sequence == 0, "first entry must be sequence 0"
		assert @playlist.playlist_entries[1].sequence == 1, "second entry must be sequence 1"
		assert @playlist.playlist_entries[2].sequence == 2, "third entry must be sequence 2"
	end

	test "user cannot change the video order to a place that's higher than number of videos" do
		login(@user)

		vid = Video.new
		vid.save

		@playlist.add_video(vid)

		post :change_video_place, playlist: @playlist.id, video: vid.id, new_place: @playlist.playlist_entries.count + 1

		assert_response :forbidden
	end

	test "user cannot change the video order to a place thats less than zero" do
		login(@user)

		vid = Video.new
		vid.save

		@playlist.add_video(vid)

		post :change_video_place, playlist: @playlist.id, video: vid.id, new_place: -5

		assert_response :forbidden
	end

	def teardown
		@playlist.playlist_entries.destroy_all
	end
end