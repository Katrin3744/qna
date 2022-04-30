require 'rails_helper'

feature 'User can give answer to the question', %q{
  In order to explore all questions from a community
  I'd like to be able to view the list of question
} do

  given(:question) { create(:question) }

  background do
    visit question_path(question)
  end

  scenario 'answers on a question' do
    fill_in 'Body', with: 'answer answer answer'
    click_on 'Send answer'

    expect(page).to have_content 'Your answer successfully created.'
    expect(page).to have_content 'answer answer answer'
  end

  scenario 'answers on a question with errors' do
    click_on 'Send answer'

    expect(page).to have_content "Body can't be blank"
  end

end