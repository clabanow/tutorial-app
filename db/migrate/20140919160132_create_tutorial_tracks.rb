class CreateTrackTutorials < ActiveRecord::Migration
  def change
    create_table :tutorial_tracks do |t|
      t.integer :tutorial_id
      t.integer :track_id
      t.string :description
      t.integer :position

      t.timestamps
    end
  end
end
