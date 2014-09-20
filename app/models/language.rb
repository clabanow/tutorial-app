class Language < ActiveRecord::Base
  before_save { self.name = name.downcase }

  has_many :language_tutorials, :dependent => :destroy
  has_many :tutorials, :through => :language_tutorials

  validates :name, presence: true,
                   uniqueness: { case_sensitive: false }
end
