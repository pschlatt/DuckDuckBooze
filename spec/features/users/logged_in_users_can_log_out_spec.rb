require 'rails_helper'

RSpec.describe 'a logged in user can log out' do
  before :each do
    @reg_user = User.create(role: 1, enabled: false, name: "Sally Shopper", street: "123 Busy Way", city: "Denver", state: "CO", zip: "80222", email: "sally@gmail.com", password: "12345678")
    @merchant = User.create(role: 2, enabled: true, name: "Mike Merchant", street: "1 Old Street", city: "Golden", state: "CO", zip: "80403", email: "mike@gmail.com", password: "password")
    @admin = User.create(role: 3, enabled: true, name: "Aaron Admin", street: "1 Old Street", city: "Golden", state: "CO", zip: "80403", email: "aaron@gmail.com", password: "badpassword")

    @item_1 = create(:item)
    @item_2 = create(:item)
  end

  context 'as a logged in regular user - when I click on log out' do
    it 'redirects me to the home page, displays a confirmation message, and any items in my cart are gone' do

      visit root_path

      click_on "Login"

      fill_in :email, with: @reg_user.email
      fill_in :password, with: @reg_user.password

      click_on "Submit"

      visit item_path(@item_1)

      click_on "Add to Cart"

      expect(page).to have_content("Cart: 1")

      click_on "Log Out"

      expect(current_path).to eq(root_path)
      expect(page).to have_content("Successfully logged out")
      expect(page).to have_content("Cart: 0")
    end
  end

  context 'as a logged in merchant - when I click on log out' do
    it 'redirects me to the home page, displays a confirmation message that I am logged out' do

      visit root_path

      click_on "Login"

      fill_in :email, with: @merchant.email
      fill_in :password, with: @merchant.password

      click_on "Submit"

      expect(page).to_not have_content("Cart: 0")

      click_on "Log Out"

      expect(current_path).to eq(root_path)
      expect(page).to have_content("Successfully logged out")
    end
  end

  context 'as a logged in admin - when I click on log out' do
    it 'redirects me to the home page, displays a confirmation message that I am logged out' do

      visit root_path

      click_on "Login"

      fill_in :email, with: @admin.email
      fill_in :password, with: @admin.password

      click_on "Submit"

      expect(page).to_not have_content("Cart: 0")

      click_on "Log Out"

      expect(current_path).to eq(root_path)
      expect(page).to have_content("Successfully logged out")
    end
  end
end
