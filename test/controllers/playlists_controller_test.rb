class PlaylistsControllerTest < ActionController::TestCase

	def setup
		@user = create_user(username: "marko", password: "lolol", email: "marko@mk.com")
	end


	test "user can create a playlist" do
		@user = create_user(username: "marko", password: "lolol", email: "marko@mk.com")
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
end