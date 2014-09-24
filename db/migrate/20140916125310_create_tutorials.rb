class CreateTutorials < ActiveRecord::Migration
  def change
    create_table :tutorials do |t|
      t.integer  :category_id
      t.decimal :rating, precision: 5, scale: 1
      t.integer :votes
      t.integer :comments
      t.string  :url
      t.string  :title
      t.string  :description
      t.integer  :author

      t.timestamps
    end
    add_index :tutorials, :category_id
    add_index :tutorials, :rating
    add_index :tutorials, :author
  end
end
