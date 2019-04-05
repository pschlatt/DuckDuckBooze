require "rails_helper"
# As an admin user
# When I click a new "Users" link in the nav (only visible to admins)
# Then my current URI route is "/admin/users"
# Only admin users can reach this path.
# I see all users in the system who are not merchants nor admins.
# Each user's name is a link to a show page for that user ("/admin/users/5")
# Next to each user's name is the date they registered
# Next to each user's name is a button that says 'Upgrade to Merchant'
describe "as an admin" do
  describe "when I go to users link" do
    it "shows all regular users" do
      admin = create(:admin)
      user_1 = create(:user)
      user_2 = create(:user)
      user_3 = create(:user)
      merchant = create(:merchant)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      visit admin_users_path

      expect(page).to have_content(user_1.name)
      expect(page).to have_content(user_1.created_at)
      expect(page).to have_link("#{user_1.name}")
      expect(page).to have_link("Upgrade to Merchant")
      expect(page).to have_content(user_2.name)
      expect(page).to have_content(user_2.created_at)
      expect(page).to have_link("#{user_2.name}")
      expect(page).to have_link("Upgrade to Merchant")
      expect(page).to have_content(user_3.name)
      expect(page).to have_content(user_3.created_at)
      expect(page).to have_link("#{user_3.name}")
      expect(page).to have_link("Upgrade to Merchant")
      expect(page).to_not have_content(merchant.name)
    end
  end
end
