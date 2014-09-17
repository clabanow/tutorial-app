class AddMediaPriceLevelToTutorials < ActiveRecord::Migration
  def change
    add_column :tutorials, :media_type_id, :integer
    add_column :tutorials, :is_paid,         :boolean
  end
end
