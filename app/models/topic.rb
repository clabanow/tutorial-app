class Topic < ActiveRecord::Base

  belongs_to :tutorial
  belongs_to :tag

  validates :tutorial_id, presence: true
  validates :tag_id, presence: true
end
