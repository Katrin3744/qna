require 'rails_helper'

feature 'User can delete question', %q{
  In order to remove my question from a community
  I'd like to be able to delete question
} do

  given(:user) { create(:user) }
  given(:other_user) { create(:user) }
  given!(:question) { create(:question, title: 'MyString1', author: user) }
  given!(:question_not_belongs_to_user) { create(:question, title: 'MyString2', author: other_user) }

  describe 'Authenticated user' do
    background do
      sign_in(user)

      visit questions_path
    end

    scenario 'delete his answer on a question' do
      click_on 'Delete'

      expect(page).to have_content 'Your question successfully deleted.'
      expect(page).to have_no_content(question.title)
    end

    scenario "delete answer on a question, that doesn't belong to him" do
      expect(page).to have_link('Delete', :count => 1)
    end
  end

  scenario 'Unauthenticated user tries to delete answer on a question' do
    visit questions_path

    expect(page).to have_no_link('Delete')
  end
end
