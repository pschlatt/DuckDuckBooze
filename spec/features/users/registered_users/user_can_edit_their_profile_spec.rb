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

      expect(page).to have_content
    end 
  end 
end 