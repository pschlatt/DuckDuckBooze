require "rails_helper"

describe 'as an admin' do
  describe 'if visiting merchant dashboard for regular user' do
    it 'redirects to user profile page' do
      admin = create(:admin)
      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_merchant_path(user)

      expect(current_path).to eq(admin_user_path(user))
    end
  end

  describe 'if visiting reg user profile for merchant' do
    it 'redirects to merchant dashboard page' do
      admin = create(:admin)
      merchant = create(:merchant)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_user_path(merchant)

      expect(current_path).to eq(admin_merchant_path(merchant))
    end
  end
end
