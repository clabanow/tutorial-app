require 'uri'

class Tutorial < ActiveRecord::Base

  validates :title, presence: true, 
                    length: { maximum: 200 }
  validates :category_id, presence: true
  validates :url, presence: true, 
                  format: { with: URI.regexp },
                  uniqueness: { case_sensitive: false }
  validates :description, length: { maximum: 500 }
  validates :media_type_id, presence: true
  validates :publisher_id, presence: true
  validates :date_created, presence: true

end
