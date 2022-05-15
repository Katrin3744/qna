require 'rails_helper'

feature 'User can sign out', %q{
  In order to exit
  As an unauthenticated user
  I'd like to be able to sign out
} do

  given(:user) { create(:user) }

  describe 'Authenticated user' do
    background do
      sign_in(user)
      visit root_path
    end

    scenario 'User tries to sign out' do
      click_on 'Exit'

      expect(page).to have_content 'Signed out successfully.'
    end
  end
end
