require 'rails_helper'

feature 'User can delete answer to the question', %q{
  In order to remove my answer from a community
  I'd like to be able to delete answer
} do

  given!(:question) { create(:question) }
  given!(:user) { create(:user) }
  given!(:answer) { create(:answer, question: question, author: user) }

  describe 'Authenticated user' do
    background do
      sign_in(user)

      visit question_path(question)

      scenario 'delete his answer on a question' do
        click_on 'Delete'

        expect(page).to have_content 'Your answer successfully deleted.'
      end

      scenario "delete answer on a question, tha doesn't belong to him" do
        click_on 'Delete'

        expect(page).to have_content "You don't have permission for that"
      end
    end
  end

  scenario 'Unauthenticated user tries to delete answer on a question' do
    visit question_path(question)
    save_and_open_page
    click_on 'Delete'

    expect(page).to have_content "You don't have permission for that"
  end
end