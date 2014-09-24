class CreatePrimaryTopics < ActiveRecord::Migration
  def change
    create_table :primary_topics do |t|
      t.string :name

      t.timestamps
    end
  end
end
