require 'spec_helper'

describe "Tag Pages" do
  let(:submit)        { "Add tag" }
  let(:original_name) { "node" }
  let(:edited_name)   { "angular" }
  subject { page }

  describe "creating a new tag" do
    before { visit new_tag_path }

    describe "submitting with invalid information" do
      it "should not create a new tag" do
        expect { click_button submit }.not_to change(Tag, :count)
      end
    end

    describe "with valid information" do
      before { fill_in "Name", with: original_name }

      it "should create a new tag" do
        expect { click_button submit }.to change(Tag, :count).by(1)
      end

      describe "after saving the tag" do
        before { click_button submit }
        let(:tag) { Tag.find_by(name: original_name) }

        describe "user should be routed to list of all tags" do
          it { should have_title(get_full_title('All tags')) }
          it { should have_selector('div.alert.alert-success', text: 'added') }
        end

        it "user should now be able to delete the tag" do
          expect { delete tag_path(tag) }.to change(Tag, :count).by(-1)
          it { should have_title(get_full_title("All tags")) }
        end

        describe "saved tag should now be editable" do
          before { visit edit_tag_path(tag) }

          specify { expect(find_field("Name").value to eq original_name) }
          it { should have_selector('h1', 'Edit tag') }

          describe "editing the tag" do
            before do
              fill_in "Name", with: edited_name
              click_button "Save tag"
            end
            let(:edited_tag) { Track.find_by(name: edited_name) }
            let(:original_tag) { Track.find_by(name: original_name) }

            specify { expect(edited_tag.name).to eq edited_name }
            specify { expect(original_tag).to eq nil }
            it { should have_title(get_full_title("All tracks")) }
            it { should have_selector('div.alert.alert-success', text: 'edited') }
          end
        end
      end
    end
  end
end