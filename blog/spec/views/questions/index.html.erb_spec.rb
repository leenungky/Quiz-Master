require 'rails_helper'

RSpec.describe "questions/index", type: :view do
  before(:each) do
    assign(:questions, [
      Question.create!(
        :question => "Question",
        :answer => 1
      ),
      Question.create!(
        :question => "Question",
        :answer => 1
      )
    ])
  end

  it "renders a list of questions" do
    render
    assert_select "tr>td", :text => "Question".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
