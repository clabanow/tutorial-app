class AddMediaPriceLevelToTutorials < ActiveRecord::Migration
  def change
    add_column :tutorials, :media_type, :integer
    add_column :tutorials, :is_paid,         :boolean
  end
end
