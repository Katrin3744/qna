require 'rails_helper'

feature "User can view question's answers", %q{
  In order to explore answers on question from a community
  I'd like to be able to view list of answers on the question
} do

  given!(:user) { create(:user) }
  given!(:question) { create(:question) }
  given!(:answer1) { create(:answer, body: 'MyText1', question: question, author: user) }
  given!(:answer2) { create(:answer, body: 'MyText2', question: question, author: user) }

  scenario "view question with it's answers" do
    visit questions_path
    click_on 'View question'

    expect(page).to have_content 'All answers'
    expect(page).to have_content(answer1.body)
    expect(page).to have_content(answer2.body)
  end
end
