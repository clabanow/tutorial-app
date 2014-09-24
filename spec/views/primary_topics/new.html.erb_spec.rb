require 'spec_helper'

describe "primary_topics/new" do
  before(:each) do
    assign(:primary_topic, stub_model(PrimaryTopic,
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new primary_topic form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", primary_topics_path, "post" do
      assert_select "input#primary_topic_name[name=?]", "primary_topic[name]"
    end
  end
end
