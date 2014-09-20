class CreateLanguageTutorials < ActiveRecord::Migration
  def change
    create_table :language_tutorials do |t|
      t.integer :tutorial_id
      t.integer :language_id

      t.timestamps
    end
    add_index :language_tutorials, :tutorial_id
    add_index :language_tutorials, :language_id
  end
end
