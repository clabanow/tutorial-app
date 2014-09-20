class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.integer :tag_id
      t.integer :tutorial_id

      t.timestamps
    end

    
  end
end
