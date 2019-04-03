require "rails_helper"

describe 'as an admin' do
  describe 'if visiting merchant dashboard for regular user' do
    it 'redirects to user profile page' do
      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit admin_merchant_path(user)

      expect(current_path).to eq(admin_user_path(user))
    end
  end
end
