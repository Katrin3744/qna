require 'rails_helper'

feature "User can view question's answers", %q{
  In order to explore answers on question from a community
  I'd like to be able to view list of answers on the question
} do
  given!(:question) { create(:question) }

  scenario "view question with it's answers" do
    visit questions_path
    click_on 'View question'
    expect(page).to have_content 'All answers'
  end

end