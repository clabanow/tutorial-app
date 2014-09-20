require 'spec_helper'

describe TrackTutorial do
  let(:tutorial) { FactoryGirl.create(:tutorial) }
  let(:track)    { FactoryGirl.create(:track) }
  before { @track_tutorial = TrackTutorial.create(tutorial_id: tutorial.id, track_id: track.id, description: 'The second one', position: 2)}
  subject { @track_tutorial }

  it { should be_valid }

  describe "should create link between tutorial and track" do
    it { should respond_to(:tutorial_id) }
    it { should respond_to(:track_id) }
    it { should respond_to(:description) }
    it { should respond_to(:position) }

    its(:tutorial) { should eq tutorial }
    its(:track)    { should eq track }

    specify { expect(TrackTutorial.count).to eq 1}
    specify { expect(TrackTutorial.find_by(tutorial_id: tutorial.id)).not_to eq nil}
    specify { expect(TrackTutorial.find_by(track_id: track.id)).not_to eq nil}
  end

  describe "deleting the tutorial should delete the tutorial_track" do
    before { tutorial.destroy }

    specify { expect(TrackTutorial.find_by(tutorial_id: tutorial.id)).to eq nil }
  end

  describe "deleting the track should delete the tutorial_track" do
    before { track.destroy }

    specify { expect(TrackTutorial.find_by(track_id: track.id)).to eq nil }
  end

  describe "validation" do
    describe "when tutorial_id is missing" do
      before { @track_tutorial.tutorial_id = '' }

      it { should_not be_valid }
    end

    describe "when track_id is missing" do
      before { @track_tutorial.track_id = '' }

      it { should_not be_valid }
    end

    describe "for description" do
      describe "when description is missing" do
        before { @track_tutorial.description = '' }

        it { should_not be_valid }
      end

      describe "when description is too long" do

      end
    end

    describe "for position" do
      describe "when position is missing" do
        before { @track_tutorial.position = '' }

        it { should_not be_valid }
      end

      describe "when position is duplicated" do
        let(:track_tutorial_same_pos) { FactoryGirl.create(:track_tutorial) }
        before { track_tutorial_same_pos.position = @track_tutorial.position }

        specify { expect(track_tutorial_same_pos).not_to be_valid }
      end
    end
  end
end
