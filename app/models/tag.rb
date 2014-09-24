class Tag < ActiveRecord::Base
  before_save { self.name = name.downcase }

  has_many :topics, :dependent => :destroy
  has_many :tutorials, :through => :topics

  validates :name, presence: true,
                   uniqueness: { case_sensitive: false }

  def name_and_value
    [name, id]
  end

end
