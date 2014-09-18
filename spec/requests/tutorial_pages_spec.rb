require 'spec_helper'

describe "Tutorial Pages" do
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
        fill_in "Category",            with: 1
        fill_in "Link",                with: "http://www.google.com"
        fill_in "A brief description", with: "A JS tutorial"
        fill_in "Author",              with: 2
        fill_in "Media type",          with: 1
        check "Paid?"  
        # date is left as default             
      end

      it "should create a new tutorial" do
        expect { click_button submit }.to change(Tutorial, :count).by(1)
      end

      describe "after saving the tutorial" do
        before { click_button submit }
        let(:tutorial) { Tutorial.find_by(title: "A new tutorial") }

        expect(tutorial).to be_valid
        it { should have_title(get_full_title('All tutorials')) }
        it { should have_selector('div.alert.alert-success', text: 'tutorial created') }

        describe "editing the tutorial" do
          before do
            visit edit_tutorial_path
            fill_in "Tutorial name", with: "An edited tutorial"
            click_button submit
            let(:edited_tutorial) { Tutorial.find_by(title: "An edited tutorial") }
          end

          expect(tutorial).not_to be_valid
          expect(edited_tutorial).to be_valid
          it { should have_title(get_full_title('All tutorials')) }
          it { should have_selector('div.alert.alert-success', text: 'tutorial edited') }
        end
      end
    end
  end


end