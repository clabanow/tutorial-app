class RemoveCategoryIdFromTutorials < ActiveRecord::Migration
  def change
    remove_column :tutorials, :category_id
  end
end
