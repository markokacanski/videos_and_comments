class ChangeOrderToSequence < ActiveRecord::Migration
  def change
  	rename_column :playlist_entries, :order, :sequence
  end
end
