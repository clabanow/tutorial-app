class DropTrackTutorials < ActiveRecord::Migration
  def change
    drop_table :tutorial_tracks
  end
end
