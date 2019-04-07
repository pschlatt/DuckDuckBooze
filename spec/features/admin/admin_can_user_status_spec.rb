require 'rails_helper'

RSpec.describe 'as an admin' do
  context 'on the merchant dashboard' do
    it 'can downgrade merchant to user - and all of that merchants items are disabled' do

      admin = create(:admin)
      merchant = create(:merchant)
      other_merchant = create(:merchant)

      item_1 = create(:item, user_id: merchant.id)
      item_2 = create(:item, user_id: merchant.id)
      item_3 = create(:item, user_id: other_merchant.id)

      visit root_path

      click_on "Login"

      fill_in :email, with: admin.email
      fill_in :password, with: admin.password

      click_on "Submit"

      visit admin_merchant_path(merchant)

      click_on "Downgrade"

      merchant.update(role: 'registered_user')
      user = merchant

      expect(current_path).to eq(admin_user_path(user))
      expect(page).to have_content("Merchant has been downgraded")
      expect(user.role).to eq("registered_user")

      expect(user.items.first.enabled).to eq(false)
      expect(user.items.last.enabled).to eq(false)
      expect(other_merchant.items.first.enabled).to eq(true)

      click_on "Log Out"

      click_on "Login"

      fill_in :email, with: merchant.email
      fill_in :password, with: merchant.password

      click_on "Submit"

      expect(current_path).to eq(profile_path)
      expect(current_path).to_not eq(dashboard_path)
    end
  end
end
