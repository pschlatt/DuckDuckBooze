require 'rails_helper'

RSpec.describe 'registered user' do
  describe 'can edit their profile data' do
    before :each do
      @user = create(:user)
      @user_2 = create(:user, email: 'email@gmail.com')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it 'via a link on their profile page' do
      visit 'profile'

      click_link('Edit Profile')
      expect(current_path).to eq('/profile/edit')
    end

    it 'sees a form to edit on /profile/edit' do
      visit 'profile/edit'

      within '#edit-user-form' do
        expect(page).to have_content('Name')
        expect(page).to have_content('Email')
        expect(page).to have_content('Password')
        expect(page).to have_content('Confirm Password')
        expect(page).to have_content('Street')
        expect(page).to have_content('City')
        expect(page).to have_content('State')
        expect(page).to have_content('Zip')
      end
    end

    it 'can edit successfully' do
      visit '/profile/edit'

      within '#edit-user-form' do
        fill_in 'Name', with: "Blah"
        click_on('Save User')
      end

      expect(current_path).to eq(profile_path)
      expect(page).to have_content("Blah")
      expect(page).to have_content('You have updated your profile')
    end

    it 'cannot edit without unique email' do
      visit '/profile/edit'

      within '#edit-user-form' do
        fill_in 'Email', with: "email@gmail.com"
        click_on('Save User')
      end

      expect(current_path).to eq('/profile/edit')
      expect(page).to have_content('Email has already been taken')
    end
  end
end
