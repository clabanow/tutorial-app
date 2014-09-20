require 'spec_helper'

describe LanguageTutorial do
  let(:tutorial) { FactoryGirl.create(:tutorial) }
  let(:language) { FactoryGirl.create(:language) }
  before { @language_tutorial = LanguageTutorial.create(language_id: language.id, tutorial_id: tutorial.id) }

  subject { @language_tutorial }

  it { should be_valid }

  describe "creating a relationship between tutorial and language" do
    it { should respond_to(:tutorial) }
    it { should respond_to(:language) }
    its(:language) { should eq language }
    its(:tutorial) { should eq tutorial }
    specify { expect(LanguageTutorial.count).to eq 1 }
    specify { expect(LanguageTutorial.find_by(language_id: language.id)).not_to eq nil }
    specify { expect(LanguageTutorial.find_by(tutorial_id: tutorial.id)).not_to eq nil }
  end

  describe "deleting a tutorial should delete the associated language_tutoiral object" do
    before { tutorial.destroy }

    specify { expect(LanguageTutorial.find_by(tutorial_id: tutorial.id)).to eq nil }
  end

  describe "deleting a language should delete the associated language_tutoiral object" do
    before { language.destroy }

    specify { expect(LanguageTutorial.find_by(language_id: language.id)).to eq nil }
  end

  describe "when no language_id is present" do
    before { @language_tutorial.language_id = nil }
    it { should_not be_valid }
  end

  describe "when no tutorial_id is present" do
    before { @language_tutorial.tutorial_id = nil }
    it { should_not be_valid }
  end
end
