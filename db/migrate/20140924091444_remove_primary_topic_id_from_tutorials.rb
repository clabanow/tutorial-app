class RemovePrimaryTopicIdFromTutorials < ActiveRecord::Migration
  def change
    remove_column :tutorials, :primary_topic_id
  end
end
