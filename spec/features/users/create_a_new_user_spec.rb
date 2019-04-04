require 'rails_helper'

RSpec.describe 'User Registration Form' do
  describe 'a user can register' do 
    it 'a new account successfully' do 
      visit root_path

      click_link 'Register'

      expect(current_path).to eq(new_user_path)
      expect(page).to have_content("CREATE AN ACCOUNT")

      fill_in 'Name', with: 'Chicken'
      fill_in 'Password', with: 'Dinner'
      fill_in 'Confirm Password', with: 'Dinner'
      fill_in 'Street', with: '123 Dead End'
      fill_in 'City', with: 'Denver'
      fill_in 'State', with: 'Colorado'
      fill_in 'Zip', with: '88888'
      fill_in 'Email', with: 'myemail@gmail.com'

      click_button 'Create User'
      new_user = User.last

      expect(current_path).to eq(profile_path)
      expect(page).to have_content("Welcome, #{new_user.name}!")
      expect(page).to have_content("You are now registered and logged in.")
    end 

    it 'cannot create an account without all required fields' do 
      visit new_user_path

      fill_in 'Name', with: 'Chicken'
      fill_in 'Password', with: 'Dinner'
      fill_in 'Confirm Password', with: 'Dinner'
      fill_in 'Street', with: '123 Dead End'
      fill_in 'City', with: 'Denver'
      fill_in 'State', with: 'Colorado'
      fill_in 'Zip', with: '88888'

      click_button 'Create User'

      expect(page).to have_content("CREATE AN ACCOUNT")
      expect(page).to have_content('Missing required field(s). Please try again.')

      fill_in 'Name', with: 'Chicken'
      fill_in 'Password', with: 'Dinner'
      fill_in 'Street', with: '123 Dead End'
      fill_in 'City', with: 'Denver'
      fill_in 'State', with: 'Colorado'
      fill_in 'Zip', with: '88888'

      click_button 'Create User'

      expect(page).to have_content("CREATE AN ACCOUNT")
      expect(page).to have_content('Missing required field(s). Please try again.')
    end 
  end 
end 