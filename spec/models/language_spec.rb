require 'spec_helper'

describe Language do
  before { @language = Language.new(
    name: 'Javascript'
    ) }

  subject { @language }

  it { should respond_to(:name) }

  it { should be_valid }

  describe "validation" do
    describe "when name is missing" do
      before { @language.name = '' }

      it { should_not be_valid }
    end
  end

  describe "when object is saved" do
    describe "name should be capitalized" do
      before do
        @language.name = "ruby"
        @language.save
      end

    its(:name) { should eq "Ruby" }
    end
  end 
end
