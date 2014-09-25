require 'spec_helper'

describe "Tutorial Pages" do
  before do
    Tag.create!(name: 'ruby')
    Tag.create!(name: 'python')
    Tag.create!(name: 'go')
  end
  subject { page }

  describe "creating a new tutorial" do
    before { visit new_tutorial_path }
    let(:submit) { 'Add tutorial' }

    describe "with invalid information" do
      it "should not create a new tutorial" do
        expect { click_button submit }.not_to change(Tutorial, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Tutorial name",       with: "A new tutorial"
        fill_in "Link",                with: "http://www.google.com"
        fill_in "A brief description", with: "A JS tutorial"
        fill_in "Author",              with: 'Guido van Rossum'
        select('Text', :from => 'Media type')
        select('python', :from => 'Primary topic')
        check "Paid?"  
        # date is left as default             
      end

      it "should create a new tutorial" do
        expect { click_button submit }.to change(Tutorial, :count).by(1)
      end

      describe "after saving the tutorial" do
        before { click_button submit }
        let(:tutorial) { Tutorial.find_by(title: "A new tutorial") }

        describe "user should be routed to list of all tutorials" do
          it { should have_title(get_full_title('All tutorials')) }
          it { should have_selector('div.alert.alert-success', text: 'tutorial created') }
        end

        it "should now be able to delete a tutorial" do
          expect { delete tutorial_path(tutorial) }.to change(Tutorial, :count).by(-1)
          expect { page.to have_title(get_full_title('All tutorials')) }
        end
        
        describe "saved tutorial should now be editable" do
          before { visit edit_tutorial_path(tutorial.id) }
          let(:title) { find_field('Tutorial name').value }

          specify { expect(tutorial.title).to eq title }
          it { should have_selector('h1', 'Edit tutorial') }

          describe "editing the tutorial" do
            before do
              fill_in "Tutorial name", with: "An edited tutorial"
              click_button 'Save tutorial'
            end
            let(:edited_tutorial) { Tutorial.find(tutorial.id) }

            specify { expect(edited_tutorial.url).to eq tutorial.url }
            it { should have_title(get_full_title('Edit tutorial')) }
            it { should have_selector('div.alert.alert-success', text: 'Tutorial edited') }
          end
        end


      end
    end
  end


end