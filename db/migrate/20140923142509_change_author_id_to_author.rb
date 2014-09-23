class ChangeAuthorIdToAuthor < ActiveRecord::Migration
  def change
    rename_column :tutorials, :publisher_id, :author
    change_column :tutorials, :author, :string
  end
end
