require "rails_helper"
#
# As an admin user
# If I visit a merchant dashboard, but that merchant is a regular user
# Then I am redirected to the appropriate user profile page.
#
# eg, if I visit "/admin/merchants/7" but that merchant is a regular user
# then I am redirected to "/admin/users/7" and see their user profile page
describe 'as an admin' do
  describe 'if visiting merchant dashboard for regular user' do
    it 'redirects to user profile page' do
      user = create(:user)
      admin = create(:admin)
      binding.pry
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_merchants_path(merchant_7)

      expect(current_path).to eq(admin_users_path(user))
    end
  end
end
