require 'rails_helper'

feature 'User can view the list of question', %q{
  In order to explore all questions from a community
  I'd like to be able to view the list of question
} do
  given!(:user) { create(:user) }
  given!(:question1) { create(:question, title: 'MyString1', author: user) }
  given!(:question2) { create(:question, title: 'MyString2', author: user) }

  scenario 'view list of questions' do
    visit questions_path

    expect(page).to have_content 'All questions'
    expect(page).to have_content(question1.title)
    expect(page).to have_content(question2.title)
  end
end
