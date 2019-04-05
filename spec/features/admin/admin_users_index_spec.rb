require "rails_helper"

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

      within ".user-#{user_1.id}-section" do
        expect(page).to have_content(user_1.name)
        expect(page).to have_content(user_1.created_at.to_s(:long))
        expect(page).to have_link("#{user_1.name}")
        expect(page).to have_link("Upgrade to Merchant")
      end
      within ".user-#{user_2.id}-section" do
        expect(page).to have_content(user_2.name)
        expect(page).to have_content(user_2.created_at.to_s(:long))
        expect(page).to have_link("#{user_2.name}")
        expect(page).to have_link("Upgrade to Merchant")
      end
      within ".user-#{user_3.id}-section" do
        expect(page).to have_content(user_3.name)
        expect(page).to have_content(user_3.created_at.to_s(:long))
        expect(page).to have_link("#{user_3.name}")
        expect(page).to have_link("Upgrade to Merchant")
      end
      expect(page).to_not have_content(merchant.name)
    end

    it "won't let merchants see Users link" do
      merchant = create(:merchant)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)

      expect(page).to_not have_link("Users")

      visit admin_users_path

      expect(page.status_code).to eq(404)
      expect(page).to have_content("The page you were looking for doesn't exist (404)")
    end
    it "won't let registered users see Users link" do
      user_1 = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

      expect(page).to_not have_link("Users")

      visit admin_users_path

      expect(page.status_code).to eq(404)
      expect(page).to have_content("The page you were looking for doesn't exist (404)")
    end

    it "won't let visitors see Users link" do

      visit root_path

      expect(page).to_not have_link("Users")

      visit admin_users_path

      expect(page.status_code).to eq(404)
      expect(page).to have_content("The page you were looking for doesn't exist (404)")
    end
  end
end
