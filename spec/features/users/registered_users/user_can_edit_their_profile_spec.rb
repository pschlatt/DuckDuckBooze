require 'rails_helper'

RSpec.describe 'registered user' do
  describe 'can edit their profile data' do
    before :each do 
      @user = create(:user)
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

    it 'sees a form to edit on /profile/edit' do
      visit '/profile/edit'
      
      within '#edit-user-form' do
        fill_in 'Name', with: "Blah"
        click_on('Save User')
      end 
      
      expect(@user.name).to eq("Blah")
      expect(page).to have_content('You have updated your profile')
    end 
  end 
end 