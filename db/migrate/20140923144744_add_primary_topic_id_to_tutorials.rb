class AddPrimaryTopicIdToTutorials < ActiveRecord::Migration
  def change
    add_column :tutorials, :primary_topic_id, :integer
  end
end
