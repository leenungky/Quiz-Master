require 'rails_helper'

RSpec.describe "questions/new", type: :view do
  before(:each) do
    assign(:question, Question.new(
      :question => "MyString",
      :answer => 1
    ))
  end

  it "renders new question form" do
    render

    assert_select "form[action=?][method=?]", questions_path, "post" do

      assert_select "input#question_question[name=?]", "question[question]"

      assert_select "input#question_answer[name=?]", "question[answer]"
    end
  end
end
