FactoryGirl.define do

  factory :tutorial do
    title 'The Ruby on Rails Tutorial'
    category_id 1
    url 'http://www.railstutorial.org'
    description 'A rails tutorial for beginners'
    publisher_id 1
    media_type_id 1
    is_paid true
    date_created Date.parse("11/11/2011")
  end

  factory :tag do
    name 'rails'
  end

  factory :language do
    name 'ruby'
  end

  factory :topic do
    tutorial_id 1
    tag_id 1
  end

  factory :track do
    name 'Learn angular'
  end

  factory :track_tutorial do
    tutorial_id 1
    track_id 3
    position 4
    description "an intro to js"
  end
end