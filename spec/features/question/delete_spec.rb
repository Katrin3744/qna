require 'rails_helper'

feature 'User can delete question', %q{
  In order to remove my question from a community
  I'd like to be able to delete question
} do

  given!(:question) { create(:question) }

  given(:user) { create(:user) }

  describe 'Authenticated user' do
    background do
      sign_in(user)

      visit questions_path

      scenario 'delete his answer on a question' do
        click_on 'Delete'

        expect(page).to have_content 'Your question successfully deleted.'
      end

      scenario "delete answer on a question, tha doesn't belong to him" do
        click_on 'Delete'

        expect(page).to have_content "You don't have permission for that"
      end
    end
  end

  scenario 'Unauthenticated user tries to delete answer on a question' do
    visit questions_path
    click_on 'Delete'

    expect(page).to have_content "You don't have permission for that"
  end
end
