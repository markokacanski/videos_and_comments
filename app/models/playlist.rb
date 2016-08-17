class Playlist < ActiveRecord::Base

	def add_video(video)
		pe = PlaylistEntry.new

		pe.video = video
		pe.playlist = self

		pe.save
	end

	has_many :playlist_entries
	has_many :videos, through: :playlist_entries
	belongs_to :user
end
