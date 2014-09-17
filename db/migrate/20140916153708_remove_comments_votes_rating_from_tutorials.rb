class RemoveCommentsVotesRatingFromTutorials < ActiveRecord::Migration
  def change
    remove_column :tutorials, :aggregate_rating
    remove_column :tutorials, :votes
    remove_column :tutorials, :comments
  end
end
