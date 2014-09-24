require 'spec_helper'

describe "primary_topics/index" do
  before(:each) do
    assign(:primary_topics, [
      stub_model(PrimaryTopic,
        :name => "Name"
      ),
      stub_model(PrimaryTopic,
        :name => "Name"
      )
    ])
  end

  it "renders a list of primary_topics" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
