class RenameTutorialRatingColumn < ActiveRecord::Migration
  def change
    rename_column :tutorials, :rating, :aggregate_rating
  end
end
