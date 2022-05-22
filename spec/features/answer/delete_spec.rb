require 'rails_helper'

feature 'User can delete answer to the question', %q{
  In order to remove my answer from a community
  I'd like to be able to delete answer
} do

  given!(:question) { create(:question) }
  given!(:user) { create(:user) }
  given!(:other_user) { create(:user) }
  given!(:answer) { create(:answer, body: 'MyText1', question: question, author: user) }
  given!(:answer_not_belong_to_user) { create(:answer, body: 'MyText2', question: question, author: other_user) }

  describe 'Authenticated user' do
    background do
      sign_in(user)

      visit question_path(question)
    end

    scenario 'delete his answer on a question' do
      click_on 'Delete'

      expect(page).to have_content 'Your answer successfully deleted.'
      expect(page).to have_no_content(answer.body)
    end

    scenario "delete answer on a question, that doesn't belong to him" do
      expect(page).to have_link('Delete', :count => 1)
    end
  end

  scenario 'Unauthenticated user tries to delete answer on a question' do
    visit question_path(question)
    expect(page).to have_no_link('Delete')
  end
end
