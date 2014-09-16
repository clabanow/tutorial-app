require 'spec_helper'

describe Tutorial do
  
  before { @tutorial = Tutorial.new(
    title: 'The Ruby on Rails Tutorial',
    category_id: 1,
    rating: 4.5,
    votes: 125,
    comments: 65,
    url: 'http://www.railstutorial.org',
    description: 'A rails tutorial for beginners',
    publisher_id: 1
    ) }

  subject { @tutorial }

  it { should respond_to(:title) }
  it { should respond_to(:category_id) }
  it { should respond_to(:rating) }
  it { should respond_to(:votes) }
  it { should respond_to(:comments) }
  it { should respond_to(:url) }
  it { should respond_to(:description) }
  it { should respond_to(:publisher_id) }

end
