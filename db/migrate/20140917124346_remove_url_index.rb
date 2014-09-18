class RemoveUrlIndex < ActiveRecord::Migration
  def change
    remove_index :tutorials, :url
  end
end
