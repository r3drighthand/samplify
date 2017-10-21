class AddImageColumnsToTracks < ActiveRecord::Migration[5.1]
  def up
    add_attachment :tracks, :image
  end

  def down
    remove_attachment :tracks, :image
  end
end
