class PlaylistEntry < ActiveRecord::Base
	default_scope do 
		order "sequence"
	end


	belongs_to :video
	belongs_to :playlist
end
