require 'spec_helper'

describe Tag do
  before { @tag = Tag.create(
    name: "Angular" 
    ) }

  subject { @tag }

  it { should respond_to(:name) }
  it { should respond_to(:topics) }
  it { should respond_to(:tutorials) }

  it { should be_valid }

  describe "validation" do
    describe "when name is missing" do
      before { @tag.name = '' }

      it { should_not be_valid }
    end
  end

  describe "when saving" do
    describe "its name should be converted to downcase" do
      before { @tag.update_attribute(:name, 'EMBER') }

      its(:name) { should eq 'ember' }
    end
  end
end
