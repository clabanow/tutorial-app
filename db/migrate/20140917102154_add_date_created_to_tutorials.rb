class AddDateCreatedToTutorials < ActiveRecord::Migration
  def change
    add_column :tutorials, :date_created, :date
  end
end
