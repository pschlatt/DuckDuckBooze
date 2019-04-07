require "rails_helper"
# As an admin user
# When I visit a user's profile page ("/admin/users/5")
# I see a link to "upgrade" the user's account to become
# a merchant
# When I click on that link
# I am redirected to ("/admin/merchants/5") because the
# user is now a merchant
# And I see a flash message indicating the user has been
# upgraded
# The next time this user logs in they are now a
# merchant
# Only admins can reach any route necessary to
# upgrade the user to merchant status
describe 'when admin visits users profile page' do
  it 'lets admin upgrade user to merchant' do
    admin = create(:admin)
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit admin_user_path(user)

    click_button "Upgrade"

    expect(current_path).to eq(admin_merchant_path(user))
    expect(page).to have_content("User has been upgraded to a merchant")

  end
end
