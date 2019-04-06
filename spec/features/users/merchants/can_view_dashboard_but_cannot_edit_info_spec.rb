require 'rails_helper'

RSpec.describe 'a merchant visiting my dashboard' do
  it 'shows my profile data, but I cannot edit the info' do

    merchant = User.create(role: 2, enabled: true, name: "Mike Merchant", street: "1 Old Street", city: "Golden", state: "CO", zip: "80403", email: "mike@gmail.com", password: "password")

    visit root_path

    click_on "Login"

    fill_in 'Email', with: merchant.email
    fill_in 'Password', with: merchant.password

    click_on "Submit"

    expect(current_path).to eq(dashboard_path)

    expect(page).to have_content("Name: #{merchant.name}")
    expect(page).to have_content("Address: #{merchant.street}")
    expect(page).to have_content("#{merchant.city}, #{merchant.state} #{merchant.zip}")
    expect(page).to have_content("Email: #{merchant.email}")

    expect(page).not_to have_content("Edit")
    expect(page).not_to have_content("edit")
  end
end
