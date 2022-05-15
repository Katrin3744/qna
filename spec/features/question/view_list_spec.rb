require 'rails_helper'

feature 'User can view the list of question', %q{
  In order to explore all questions from a community
  I'd like to be able to view the list of question
} do

  scenario 'view list of questions' do
    visit questions_path
    expect(page).to have_content 'All questions'
  end
end
