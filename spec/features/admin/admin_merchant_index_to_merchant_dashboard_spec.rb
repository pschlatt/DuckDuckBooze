require 'rails_helper'

RSpec.describe 'as an admin user' do
  context 'when I visit the merchant index page and click on a merchants name' do
    it 'redirects to a show page for that merchant, where the admin sees everything that the merchant does' do

      admin = create(:admin)
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit merchants_path

      click_on "#{merchant_1.name}"
    
      expect(current_path).to eq(admin_merchant_path(merchant_1))
      expect(page).to have_content("Name: #{merchant_1.name}")
      expect(page).to have_content("Address: #{merchant_1.street}")
      expect(page).to have_content("#{merchant_1.city}, #{merchant_1.state} #{merchant_1.zip}")
      expect(page).to have_content("Email: #{merchant_1.email}")
    end
  end
end

# As an admin user
# When I visit the merchant index page ("/merchants")
# And I click on a merchant's name,
# Then my URI route should be ("/admin/merchants/6")
# Then I see everything that merchant would see
