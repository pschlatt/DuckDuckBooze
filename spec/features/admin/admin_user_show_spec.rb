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

  it 'lets admin see user info except edit button' do
    admin = create(:admin)
    user = User.create!(name: "Joe", email: "joe@turing.com", street: "123 Main", city: "Waikiki", state: "HI", zip: "99315", password: "password")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    visit admin_user_path(user)

    expect(page).to have_content("Name: #{user.name}")
    expect(page).to have_content("Email: #{user.email}")
    expect(page).to have_content("Street: #{user.street}")
    expect(page).to have_content("City: #{user.city}")
    expect(page).to have_content("State: #{user.state}")
    expect(page).to have_content("Zip: #{user.zip}")
    expect(page).to_not have_link("Edit Profile")
  end
end
