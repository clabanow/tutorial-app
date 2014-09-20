class TrackTutorial < ActiveRecord::Base
  belongs_to :tutorial
  belongs_to :track

  validates :tutorial_id, presence: true
  validates :track_id, presence: true
  validates :description, presence: true
  validates :position, presence: true, uniqueness: true
end
