require 'uri'

class Tutorial < ActiveRecord::Base
  before_validation :format_url
  before_save       :format_url

  has_many :topics, :dependent => :destroy
  has_many :tags, :through => :topics

  has_many :language_tutorials, :dependent => :destroy
  has_many :languages, :through => :language_tutorials

  has_many :track_tutorials, :dependent => :destroy
  has_many :tracks, :through => :track_tutorials

  validates :title, presence: true, 
                    length: { maximum: 200 }
  validates :category_id, presence: true
  validates :url, presence: true,
                  format: { with: URI.regexp },
                  uniqueness: { case_sensitive: false }
  validates :description, length: { maximum: 500 }
  validates :media_type, presence: true
  validates :author
  validates :date_created, presence: true

  def has_language?(language)
    language_tutorials.find_by(language_id: language.id)
  end

  def add_language!(language) 
    language_tutorials.create!(language_id: language.id)
  end

  def remove_language!(language)
    language_tutorials.find_by(language_id: language.id).destroy
  end

  def has_topic?(tag)
    topics.find_by(tag_id: tag.id)
  end

  def add_topic!(tag)
    topics.create!(tag_id: tag.id)
  end

  def remove_topic!(tag)
    topics.find_by(tag_id: tag.id).destroy
  end

  private

    def format_url
      return self.url if self.url.empty?

      prefix = "http://"
      trimmed_url = ''
      url = self.url.downcase

      starts_with_www      = url[0..3]  == "www."
      starts_with_httpwww  = url[0..10] == "http://www."
      starts_with_httpswww = url[0..11] == "https://www."
      starts_with_http     = url[0..6]  == "http://"
      starts_with_https    = url[0..7]  == "https://"

      if starts_with_www
        trimmed_url = url[4..-1]
      elsif starts_with_httpwww
        trimmed_url = url[11..-1]
      elsif starts_with_httpswww
        trimmed_url = url[12..-1]
      elsif starts_with_http
        trimmed_url = url[7..-1]
      elsif starts_with_https
        trimmed_url = url[8..-1]
      else
        trimmed_url = url
      end

      self.url = "#{prefix}#{trimmed_url}"
    end

end
