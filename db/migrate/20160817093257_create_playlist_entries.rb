class CreatePlaylistEntries < ActiveRecord::Migration
  def change
    create_table :playlist_entries do |t|
      t.integer :order
      t.integer :video_id
      t.integer :playlist_id

      t.timestamps null: false
    end
  end
end
