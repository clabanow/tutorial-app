require 'spec_helper'

describe TracksController do
  describe "adding a track" do
    let(:track) { FactoryGirl.create(:track) }
    before { track.save }

    it "should increase the Track count by 1" do
      expect(Track.count).to eq 1 
    end

    describe "then editing the track" do
      let(:new_name) { "A new name" }
      before { Track.first.update_attribute(:name, new_name) }

      specify { expect(Track.first.name).to eq new_name }
    end

    describe "then deleting the track" do
      before { track.destroy }

      specify { expect(Track.count).to eq 0 }
    end
  end
end
