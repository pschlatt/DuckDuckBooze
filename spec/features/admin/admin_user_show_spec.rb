require "rails_helper"

describe 'when admin visits users profile page' do
  it 'lets admin upgrade user to merchant' do
    admin = create(:admin)
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit admin_user_path(user)

    click_link "Upgrade"
    user.update(role: 2)
    new_merch = user
 
    expect(current_path).to eq(admin_merchant_path(new_merch))
    expect(page).to have_content("User has been upgraded to a merchant")
  end
end
