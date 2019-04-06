require 'rails_helper'

RSpec.describe 'merchant index page' do
  context 'as a visitor visiting the merchant index page' do
    it 'shows all active merchants in the system - with their city, state, and date they registered' do

      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)
      merchant_3 = create(:disabled_merchant)

      visit merchants_path

      expect(page).not_to have_content(merchant_3.name)

      within "#merchant-#{merchant_1.id}" do
        expect(page).to have_content("Name: #{merchant_1.name}")
        expect(page).to have_content("Location: #{merchant_1.city}, #{merchant_1.state}")
        expect(page).to have_content("Registered: #{merchant_1.created_at.strftime("%b %d, %Y")}")
      end
    end
  end
end
