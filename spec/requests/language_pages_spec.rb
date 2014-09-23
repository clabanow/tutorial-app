require 'spec_helper'

describe "Language Pages" do
  let(:submit)        { "Add language" }
  let(:original_name) { "javascript" }
  let(:edited_name)   { "ruby" }
  subject { page }

  describe "creating a new language" do
    before { visit new_language_path }

    describe "submitting with invalid information" do
      it "should not increase the number of languages" do
        expect { click_button submit }.not_to change(Language, :count)
      end
    end

    describe "with valid information" do
      before { fill_in "Name", with: original_name }

      it "should create a new language" do
        expect { click_button submit }.to change(Language, :count).by(1)
      end

      describe "after saving the language" do
        before { click_button submit }
        let(:language) { Language.find_by(name: original_name) }

        specify { expect(Language.count).to eq 1 }

        describe "user should be routed to a list of all languages" do
          it { should have_title(get_full_title("All languages")) }
          it { should have_selector('div.alert.alert-success', text: 'added') }
        end

        it "user should be able to delete the language" do
          expect { delete language_path(language) }.to change(Language, :count).by(-1)
          expect { page.to have_title(get_full_title("All languages")) }
        end

        describe "saved language should be editable" do
          before { visit edit_language_path(language) }

          specify { expect(find_field("Name").value).to eq original_name }
          it { should have_selector('h1', 'Edit language') }

          describe "editing the language" do
            before do
              fill_in "Name", with: edited_name
              click_button "Save language"
            end
            let(:edited_language)   { Language.find_by(name: edited_name) }
            let(:original_language) { Language.find_by(name: original_name) }

            specify { expect(original_language).to eq nil }
            specify { expect(edited_language.name).to eq edited_name }
            it { should have_title(get_full_title("All languages")) }
            it { should have_selector('div.alert.alert-success', text: 'edited') }
          end
        end
      end
    end
  end
end