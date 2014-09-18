class AddUrlIndex < ActiveRecord::Migration
  def change
    add_index :tutorials, :url, unique: true
  end
end
