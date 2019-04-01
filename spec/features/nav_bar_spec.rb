require 'rails_helper'

RSpec.describe 'navigation bar' do 
  context 'as a visitor' do 
    it 'should see a navigation bar' do
      visit root_path

      within '#nav-bar' do 
        expect(page).to have_link('Shop Beers')
        expect(page).to have_link('Merchants')
        expect(page).to have_link('Cart')
        #Next to the shopping cart link I see a count of the items in my cart
        expect(page).to have_link('Login')
        expect(page).to have_link('Register')
        click_on 'Shop Beers'
      end 

      expect(current_path).to eq(items_path)

      within '#nav-bar' do 
        click_on 'Merchants'
      end  

      expect(current_path).to eq(merchants_users_path)

      within '#nav-bar' do 
        click_on 'Cart'
      end  
      
      expect(current_path).to eq(login_path)

      within '#nav-bar' do 
        click_on 'Register'
      end  

      expect(current_path).to eq(new_user_path)

       within '#nav-bar' do 
        click_on 'Cart'
      end  

      expect(current_path).to eq(cart_path)
    end
  end 

  context 'as a registered user' do 
    it 'should see a navigation bar' do
      visit root_path

      within '#nav-bar' do 
        expect(page).to have_link('Shop Beers')
        expect(page).to have_link('Merchants')
        expect(page).to have_link('Cart')
        #Next to the shopping cart link I see a count of the items in my cart
        expect(page).to have_link('Login')
        expect(page).to have_link('Register')
        click_on 'Register'
      end 

      user = create(:user, role: 1)
      visit login_path

      expect(current_path).to eq(profile_path)

      within '#nav-bar' do 
        expect(page).to_not have_link('Login')
        expect(page).to_not have_link('Register')
        expect(page).to have_content('Logged in as user')
        expect(page).to have_link('Log Out')
        click_on 'Log Out'
      end  
    end
  end 
end 