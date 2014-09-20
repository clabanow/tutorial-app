class Track < ActiveRecord::Base
  has_many :track_tutorials, :dependent => :destroy
  has_many :tutorials, :through => :track_tutorials

  validates :name, presence: true
end
