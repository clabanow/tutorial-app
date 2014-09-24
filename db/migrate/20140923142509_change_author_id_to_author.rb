class ChangeAuthorIdToAuthor < ActiveRecord::Migration
  def change
    rename_column :tutorials, :author, :author
    change_column :tutorials, :author, :string
  end
end
