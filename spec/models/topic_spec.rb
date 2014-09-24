require 'spec_helper'

describe Topic do
  let(:tutorial) { FactoryGirl.create(:tutorial) }
  let(:tag)      { FactoryGirl.create(:tag) }

  before { @topic = Topic.create(tag_id: tag.id, 
                                 tutorial_id: tutorial.id,
                                 is_primary_topic: true) }
  
  subject { @topic }

  it { should be_valid }

  describe "should create a relationship between tutorial and tag" do
    it { should respond_to(:tutorial) }
    it { should respond_to(:tag) }
    its(:tag) { should eq tag }
    its(:tutorial) { should eq tutorial }
    specify { expect(Topic.count).to eq 1 }
    specify { expect(Topic.find_by(tag_id: tag.id)).not_to eq nil }
    specify { expect(Topic.find_by(tutorial_id: tutorial.id)).not_to eq nil }
  end

  describe "tag and tutorial combination should be unique" do
    before { @topic_dup = Topic.new(tag_id: tag.id, tutorial_id: tutorial.id) }
    subject { @topic_dup }

    it { should_not be_valid }
  end

  describe "each tutorial can only have one primary topic" do
    before { @another_primary_topic = Topic.new(tag_id: tag.id + 1, tutorial_id: tutorial.id, is_primary_topic: true) }
    subject { @another_primary_topic }

    it { should_not be_valid }
  end

  describe "each tutorial can have many non-primary topics" do
    before { @another_topic = Topic.new(tag_id: tag.id + 1, tutorial_id: tutorial.id, is_primary_topic: false) }
    subject { @another_topic }

    it { should be_valid }
  end

  describe "deleting a tutorial should delete the topic" do
    before { tutorial.destroy }

    specify { expect(Topic.find_by(tutorial_id: tutorial.id)).to eq nil }
  end

  describe "deleting a tag should delete the topic" do
    before { tag.destroy }

    specify { expect(Topic.find_by(tag_id: tag.id)).to eq nil }
  end

  describe "when no tag_id is present" do
    before { @topic.tag_id = nil }
    it { should_not be_valid }
  end

  describe "when no tutorial_id is present" do
    before { @topic.tutorial_id = nil }
    it { should_not be_valid }
  end
end
