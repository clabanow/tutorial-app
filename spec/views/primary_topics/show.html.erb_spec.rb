require 'spec_helper'

describe "primary_topics/show" do
  before(:each) do
    @primary_topic = assign(:primary_topic, stub_model(PrimaryTopic,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end
end
