class Playlist < ActiveRecord::Base

	def add_video(video)
		pe = PlaylistEntry.new

		pe.video = video
		pe.playlist = self

		# no entries, first one is number 0
		# one entrie, second one is number 1
		# etc... we get a neat 0-indexed ordering list
		pe.sequence = self.playlist_entries.count
		pe.save
	end

	def videos
		vids = []
		self.playlist_entries.each do |entry|
			vids << entry.video
		end

		return vids
	end


	has_many :playlist_entries
	belongs_to :user
end
