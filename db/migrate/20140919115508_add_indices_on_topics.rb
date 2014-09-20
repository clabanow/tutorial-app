class AddIndicesOnTopics < ActiveRecord::Migration
  def change
    add_index :topics, :tag_id
    add_index :topics, :tutorial_id
  end
end
