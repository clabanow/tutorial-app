FactoryGirl.define do
  factory :tutorial do
    name 'The Ruby on Rails Tutorial'
    category 'Libraries and Platforms'
    rating 4.5
    votes 125
    comments 65
    url 'http://www.railstutorial.org'
    description 'A rails tutorial for beginners'
    publisher 'Michael Hartl'
  end
end