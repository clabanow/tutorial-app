class ChangeMediaTypeToString < ActiveRecord::Migration
  def change
    rename_column :tutorials, :media_type, :media_type
    change_column :tutorials, :media_type, :string
  end
end
