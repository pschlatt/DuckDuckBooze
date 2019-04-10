require 'rails_helper'

RSpec.describe 'User Registration Failure Message After Form' do
  describe 'a user can try to register' do
    before :each do
      @user_duplicate_email = User.create(name: 'Chicken', password: 'Dinner',
        street: '123 Dead End', city: 'Denver', state: 'Colorado', zip: '88888', email: 'myemail@gmail.com')
    end

    it 'a failed input will refresh with a message' do
      visit root_path

      click_on 'Register'

      expect(current_path).to eq(new_user_path)

      fill_in 'Name', with: 'Chicken'
      fill_in 'Password', with: ''
      fill_in 'Confirm Password', with: ''
      fill_in 'Street', with: '123 Dead End'
      fill_in 'City', with: 'Denver'
      fill_in 'State', with: 'Colorado'
      fill_in 'Zip', with: '88888'
      fill_in 'Email', with: 'myemail@gmail.com'

      click_button 'Create User'

      expect(current_path).to eq(users_path)

      expect(page).to have_content('Email has already been taken')
      expect(page).to have_content("Password can't be blank")
    end
  end
end
