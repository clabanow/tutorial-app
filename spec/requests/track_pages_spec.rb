require 'spec_helper'

describe "Track Pages" do
  let(:submit)         { "Add track" }
  let(:original_name)  { "Learn to program in Javascript" }
  let(:edited_name)    { "Learn node" }
  subject { page }

  describe "creating a new tutorial" do
    before { visit new_track_path }

    describe "submitting with invalid information" do
      it "should not create a new track" do
        expect { click_button submit }.not_to change(Tutorial, :count)
      end
    end

    describe "with valid information" do
      before { fill_in "Name", with: original_name }

      it "should create a new track" do
        expect { click_button submit }.to change(Track, :count).by(1)
      end

      describe "after saving the track" do
        before { click_button submit }
        let(:track) { Track.find_by(name: original_name) }

        specify { expect(Track.count).to eq 1}

        describe "user should now be routed to the page of the created track" do
          it { should have_selector('h1', text: original_name) }
          it { should have_selector('div.alert.alert-success', text: 'added') }
        end

        it "user should now be able to delete the track" do
          expect { delete track_path(track) }.to change(Track, :count).by(-1)
          expect { page.to have_title(get_full_title("All tracks")) }
        end

        describe "saved track should now be editable" do
          before { visit edit_track_path(track) }

          specify { expect(find_field("Name").value).to eq original_name }
          it { should have_selector('h1', 'Edit track') }

          describe "editing the track" do
            before do
              fill_in "Name", with: edited_name
              click_button "Save track"
            end
            let(:edited_track)   { Track.find_by(name: edited_name) }
            let(:original_track) { Track.find_by(name: original_name) }

            specify { expect(edited_track.name).to eq edited_name }
            specify { expect(original_track).to eq nil }
            it { should have_selector('h1', text: edited_name) }
            it { should have_selector('div.alert.alert-success', text: 'edited') }
          end
        end
      end
    end
  end
end