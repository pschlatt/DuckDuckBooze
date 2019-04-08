require 'rails_helper'

RSpec.describe 'navigation bar' do
  context 'as a visitor' do
    it 'should see a navigation bar with links' do
      visit root_path

      within '#nav-bar' do
        expect(page).to have_link('Shop Beers')
        expect(page).to have_link('Merchants')
        expect(page).to have_link('Cart')
        expect(page).to have_content('Cart: 0')
        expect(page).to have_link('Login')
        expect(page).to have_link('Register')
        click_on 'Shop Beers'
      end

      expect(current_path).to eq(items_path)

      within '#nav-bar' do
        click_on 'Merchants'
      end

      expect(current_path).to eq(merchants_path)

      within '#nav-bar' do
        click_on 'Cart'
      end

      expect(current_path).to eq(cart_path)

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
    it 'should see a navigation bar with links' do
      reg_user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(reg_user)

      visit profile_path

      within '#nav-bar' do
        expect(page).to_not have_link('Login')
        expect(page).to_not have_link('Register')
        expect(page).to have_link('Log Out')
        expect(page).to have_link('Profile')
        expect(page).to have_content("Logged in as #{reg_user.name}")
      end
    end
  end

  context 'as a merchant' do
    it 'should see a navigation bar with links' do
      merchant = create(:merchant)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)

      visit merchants_path

      within '#nav-bar' do
        expect(page).to_not have_link('Login')
        expect(page).to_not have_link('Register')
        expect(page).to_not have_link('Cart')
        expect(page).to have_link('Log Out')
        expect(page).to have_link('Dashboard')
        expect(page).to have_content("Logged in as Merchant")
      end
    end
  end

  context 'as an admin' do
    it 'should see a navigation bar with links' do
      admin = create(:admin)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_user_path(admin)

      within '#nav-bar' do
        expect(page).to_not have_link('Login')
        expect(page).to_not have_link('Register')
        expect(page).to_not have_link('Cart')
        expect(page).to have_link('Log Out')
        expect(page).to have_link('Dashboard')
        expect(page).to have_content("Logged in as Admin")
      end
    end
  end
end
