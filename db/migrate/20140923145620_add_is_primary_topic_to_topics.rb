class AddIsPrimaryTopicToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :is_primary_topic, :boolean
  end
end
