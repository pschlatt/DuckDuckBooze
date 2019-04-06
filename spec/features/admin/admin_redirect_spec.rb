require "rails_helper"

describe 'as an admin' do
  describe 'if visiting merchant dashboard for regular user' do
    it 'redirects to user profile page' do
      admin = create(:admin)
      inactive_mer = create(:disabled_merchant)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_merchant_path(inactive_mer)

      expect(current_path).to eq(admin_user_path(inactive_mer))
    end
  end
end
