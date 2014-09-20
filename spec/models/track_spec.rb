require 'spec_helper'

describe Track do
  before { @track = Track.create(name: 'Backbone') }
  subject { @track }

  it { should respond_to(:name) }
  it { should respond_to(:track_tutorials) }
  it { should respond_to(:tutorials) }

  it { should be_valid }

  describe "when name is missing" do
    before { @track.name = '' }

    it { should_not be_valid }
  end
end
