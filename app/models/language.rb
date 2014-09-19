class Language < ActiveRecord::Base
  before_save { self.name = name.capitalize }

  validates :name, presence: true,
                   uniqueness: { case_sensitive: false}
end
