require 'rails_helper'

RSpec.describe 'a visitor logging in - login path' do
  before :each do
    @reg_user = User.create(role: 1, enabled: false, name: "Sally Shopper", street: "123 Busy Way", city: "Denver", state: "CO", zip: "80222", email: "sally@gmail.com", password: "12345678")
    @merchant = User.create(role: 2, enabled: true, name: "Mike Merchant", street: "1 Old Street", city: "Golden", state: "CO", zip: "80403", email: "mike@gmail.com", password: "password")
    @admin = User.create(role: 3, enabled: true, name: "Aaron Admin", street: "1 Old Street", city: "Golden", state: "CO", zip: "80403", email: "aaron@gmail.com", password: "badpassword")
  end

  context 'as a regular user logging in' do
    it 'shows fields for email address and password - after valid log in I am redirected to my profile page, and I see a confirmation message' do

      visit root_path

      click_on "Login"

      fill_in :email, with: @reg_user.email
      fill_in :password, with: @reg_user.password

      click_on "Submit"

      expect(current_path).to eq(profile_path)
      expect(page).to have_content("Login successful!")
    end
  end

  context 'as a merchant logging in' do
    it 'shows fields for email address and password - after valid log in I am redirected to my profile page, and I see a confirmation message' do

      visit root_path

      click_on "Login"

      fill_in :email, with: @merchant.email
      fill_in :password, with: @merchant.password

      click_on "Submit"

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("Login successful!")
    end
  end

  context 'as an admin logging in' do
    it 'shows fields for email address and password - after valid log in I am redirected to my profile page, and I see a confirmation message' do

      visit root_path

      click_on "Login"

      fill_in :email, with: @admin.email
      fill_in :password, with: @admin.password

      click_on "Submit"

      expect(current_path).to eq(root_path)
      expect(page).to have_content("Login successful!")
    end
  end
end
