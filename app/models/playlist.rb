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

	def move_video(video_id, new_position)

		# sanity check
		new_position = Integer(new_position)
		if new_position < 0 or new_position > (playlist_entries.count - 1)
			return false
		end

		# if we're moving the video up the list, than those before it and after the 
		# new spot need to go down one position each, and vice-versa for moving down the list

		entry = playlist_entries.find_by(video_id: video_id)		

		if new_position > entry.sequence
			#move down
			entries_to_move = playlist_entries.where("sequence > ? AND sequence <= ? ", entry.sequence, new_position)

			entries_to_move.each do |e|
				e.sequence = e.sequence - 1
				e.save
			end
		elsif new_position < entry.sequence
			#move up
			entries_to_move = playlist_entries.where("sequence < ? AND sequence >= ?", entry.sequence, new_position)

			entries_to_move.each do |e|
				e.sequence = e.sequence + 1
				e.save
			end
		else
			#do nothing
		end

		# set the sequence of the entry to the desired value
		entry.sequence = new_position
		
		return entry.save			
	end


	has_many :playlist_entries
	belongs_to :user
end
