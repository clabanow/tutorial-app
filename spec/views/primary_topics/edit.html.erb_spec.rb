require 'spec_helper'

describe "primary_topics/edit" do
  before(:each) do
    @primary_topic = assign(:primary_topic, stub_model(PrimaryTopic,
      :name => "MyString"
    ))
  end

  it "renders the edit primary_topic form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", primary_topic_path(@primary_topic), "post" do
      assert_select "input#primary_topic_name[name=?]", "primary_topic[name]"
    end
  end
end
