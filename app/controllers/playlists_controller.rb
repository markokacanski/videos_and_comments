class PlaylistsController < ApplicationController
	def new
		users_only or return
		@playlist = Playlist.new
		@playlist.name = params[:name]

		@playlist.user = current_user
		@playlist.save
	end

	def add_video
		users_only or return

		current_user.playlists.find(params[:playlist]).add_video(Video.find(params[:video]))


		
		# double logged in check because the redirect in users_only method does not
		# halt the execution, hence redirect is called twice and its a no-no in Rails
		if logged_in?
			redirect_to 'videos/list'
		end		
	end
end