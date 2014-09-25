require 'uri'

class Tutorial < ActiveRecord::Base
  attr_accessor :primary_topic_id

  before_save       :convert_url_for_saving

  before_update :check_for_new_primary_id

  after_create :set_primary_topic

  has_many :topics, :dependent => :destroy
  has_many :tags, :through => :topics

  has_many :language_tutorials, :dependent => :destroy
  has_many :languages, :through => :language_tutorials

  has_many :track_tutorials, :dependent => :destroy
  has_many :tracks, :through => :track_tutorials

  validates :title, presence: true, 
                    length: { maximum: 200 }
  validates :description, length: { maximum: 500 }
  validates :media_type, presence: true
  validates :date_created, presence: true
  validates :primary_topic_id, presence: true, :on => :create

  validate  :url_is_present_and_valid_and_unique

  def primary_topic
    Tag.find(topics.find_by(is_primary_topic: true).tag_id)
  end

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

    def check_for_new_primary_id
      if self.primary_topic_id != primary_topic.id
        primary_topic.destroy
      end
    end

    def set_primary_topic
      Topic.create!(tutorial_id: self.id, tag_id: self.primary_topic_id, is_primary_topic: true)
    end

    def url_is_present_and_valid_and_unique
      self.url = format_url("http://")

      if self.url.empty?
        errors.add(:url, "cannot be empty")
      elsif !PublicSuffix.valid?(format_url("www."))
        errors.add(:url, "is not a valid URL")
      elsif Tutorial.where(:url => self.url).exists?
        errors.add(:url, "already exists")
      end
    end

    def convert_url_for_saving
      self.url = format_url('http://')
    end

    def format_url(prefix)
      return self.url if self.url.empty?

      trimmed_url = ''
      url = self.url.strip.downcase

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

      "#{prefix}#{trimmed_url}"
    end

end
