require 'spec_helper'

describe Tutorial do
  
  before { @tutorial = Tutorial.new(
    title: 'The Ruby on Rails Tutorial',
    category_id: 1,
    url: 'http://www.railstutorial.org',
    description: 'A rails tutorial for beginners',
    publisher_id: 1,
    media_type: 'text',
    is_paid: false,
    date_created: Date.parse('1-1-2014')
    ) }

  subject { @tutorial }

  it { should respond_to(:title) }
  it { should respond_to(:category_id) }
  it { should respond_to(:url) }
  it { should respond_to(:description) }
  it { should respond_to(:publisher_id) }
  it { should respond_to(:media_type) }
  it { should respond_to(:is_paid) }
  it { should respond_to(:date_created) }
  it { should respond_to(:topics) }
  it { should respond_to(:tags) }
  it { should respond_to(:language_tutorials) }
  it { should respond_to(:languages) }

  it { should be_valid }

  describe "adding a language" do
    let(:language) { FactoryGirl.create(:language) }
    before do
      @tutorial.save
      @tutorial.add_language!(language)
    end

    specify { expect(LanguageTutorial.find_by(tutorial_id: @tutorial.id)).not_to eq nil }
    it { should have_language(language) }
    its(:languages) { should include(language) }

    describe "and removing a language" do
      before { @tutorial.remove_language!(language) }

      it { should_not have_language(language) }
      its(:languages) { should_not include(language) }
    end
  end

  describe "adding a topic" do
    let(:tag) { FactoryGirl.create(:tag) }
    before do
      @tutorial.save
      @tutorial.add_topic!(tag)
    end

    specify { expect(Topic.find_by(tutorial_id: @tutorial.id)).not_to eq nil }
    it { should have_topic(tag) }
    its(:tags) { should include(tag) }

    describe "and removing a tag" do
      before { @tutorial.remove_topic!(tag) }

      it { should_not have_topic(tag) }
      its(:tags) { should_not include(tag) }
    end
  end

  describe "validation" do

    describe "date attribute" do
      describe "when date is not present" do
        before { @tutorial.date_created = nil }

        it { should_not be_valid }
      end
    end

    describe "title attribute" do

      describe "when title is not present" do
        before { @tutorial.title = '' }
        
        it { should_not be_valid }
      end

      describe "when title is too long" do
        before { @tutorial.title = 'a' * 201 }
        
        it { should_not be_valid }
      end
    end

    describe "when category_id attribute is not present" do
      before { @tutorial.category_id = nil }

      it { should_not be_valid }
    end

    describe "url attribute" do

      describe "when url is missing" do
        before { @tutorial.url = '' }

        it { should_not be_valid }
      end

      # describe "when url is not in correct format" do
      #   wrong_urls = %w[hello hello_com hello.co+m hello.commy hello.]

      #   wrong_urls.each do |url|
      #     before { @tutorial.url = url }
          
      #     it { should_not be_valid }
      #   end
      # end

      describe "when url is in correct format" do
        correct_urls = %w[hello.com google.com hello.hey.com www.hello.com http://www.hello.com]

        correct_urls.each do |url|
          before { @tutorial.url = url }

          it { should be_valid }
        end
      end
    end

    describe "description attribute" do

      describe "when description is too long" do
        before { @tutorial.description = 'a' * 501}

        it { should_not be_valid }
      end
    end

    describe "publisher_id attribute is missing" do
      before { @tutorial.publisher_id = nil }

      it { should_not be_valid }
    end

    describe "media_type attribute is missing" do
      before { @tutorial.media_type = nil }

      it { should_not be_valid }
    end

    describe "when url has already been saved" do
      let(:site_with_same_url) { @tutorial.dup }
      subject { site_with_same_url }
      before do
        site_with_same_url.url = @tutorial.url.upcase
        @tutorial.save
      end

      it { should_not be_valid }
    end

    describe "when url leads to site already in database" do
      before { @tutorial.save }
      let(:duplicate_site) { @tutorial.dup }

      it "should not only differ in http prefix" do
        duplicate_site.url = "www.railstutorial.org"
        duplicate_site.save

        expect(duplicate_site).to_not be_valid
      end

      it "should not only differ in www prefix" do
        duplicate_site.url = "railstutorial.org"
        duplicate_site.save

        expect(duplicate_site).to_not be_valid
      end
        
    end
    
  end

end
