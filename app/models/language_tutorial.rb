class LanguageTutorial < ActiveRecord::Base
  belongs_to :tutorial
  belongs_to :language

  validates :tutorial_id, presence: true
  validates :language_id, presence: true
end
