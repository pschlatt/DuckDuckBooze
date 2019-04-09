require 'rails_helper'

RSpec.describe 'As an admin' do
  describe 'when visiting /admin/merchants index page' do
    it 'sees all merchants and their info with disable/enable button' do
      admin = create(:admin)
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)
      dis_merch = create(:disabled_merchant)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      
      visit admin_merchants_path

      within "#merchant-#{merchant_1.id}" do
        expect(page).to have_link("#{merchant_1.name}")
        expect(page).to have_content("#{merchant_1.city}")
        expect(page).to have_content("#{merchant_1.state}")
        expect(page).to have_button("Disable")
      end

      within "#merchant-#{merchant_2.id}" do
        expect(page).to have_link("#{merchant_2.name}")
        expect(page).to have_content("#{merchant_2.city}")
        expect(page).to have_content("#{merchant_2.state}")
        expect(page).to have_button("Disable")
      end
  
      within "#merchant-#{dis_merch.id}" do
        expect(page).to have_link("#{dis_merch.name}")
        expect(page).to have_content("#{dis_merch.city}")
        expect(page).to have_content("#{dis_merch.state}")
        expect(page).to have_button("Enable")
      end
    end 
  end
end
