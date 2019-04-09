require 'rails_helper'

RSpec.describe 'An admin' do
  describe 'on the merchant index' do
    it 'can disable an active merchant' do
      admin = create(:admin)
      merchant = create(:merchant)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit merchants_path 

      click_button 'Disable'
      merchant.reload

      expect(current_path).to eq(admin_merchants_path)
      expect(page).to have_content("Merchant is now disabled")
      expect(merchant.enabled?).to be_falsy
    end 

    it 'can enable an active merchant' do
      admin = create(:admin)
      merchant = create(:merchant, enabled: false)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit merchants_path 

      click_button 'Enable'
      merchant.reload

      expect(current_path).to eq(admin_merchants_path)
      expect(page).to have_content("Merchant is now enabled")
      expect(merchant.enabled?).to be_truthy
    end 

    it 'merchant cannot log back in if disabled' do 
      inactive_merchant = create(:merchant, enabled: false)
      visit root_path

      click_link "Login"

      fill_in :email, with: inactive_merchant.email
      fill_in :password, with: inactive_merchant.password

      click_on "Submit"

      expect(page).to have_content("Invalid Credentials")
    end 

    it 'merchant can log back in if enabled' do 
      merchant = create(:merchant)
      visit root_path

      click_link "Login"

      fill_in :email, with: merchant.email
      fill_in :password, with: merchant.password

      click_on "Submit"

      expect(current_path).to eq(dashboard_path)
    end 
  end 
end 