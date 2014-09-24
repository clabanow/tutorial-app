class Topic < ActiveRecord::Base

  belongs_to :tutorial
  belongs_to :tag

  validates :tutorial_id, presence: true
  validates :tag_id, presence: true
  validates :tutorial_id, :uniqueness => { :scope => :tag_id }
  validate  :tutorial_id_when_primary

  private

    def tutorial_id_when_primary
      if is_primary_topic and Topic.exists? ["tutorial_id = ? AND is_primary_topic = true AND id != ?", tutorial_id, id.to_i]
        errors.add(:tutorial_id, "Tutorial already has a primary topic")
      end 
    end
end
