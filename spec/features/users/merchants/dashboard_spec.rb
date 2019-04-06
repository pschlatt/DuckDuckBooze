require 'rails_helper'

RSpec.describe 'a merchant visiting my merchant dashboard' do
  before :each do
    @merchant = User.create(role: 2, enabled: true, name: "Mike Merchant", street: "1 Old Street", city: "Golden", state: "CO", zip: "80403", email: "mike@gmail.com", password: "password")

    visit root_path

    click_on "Login"

    fill_in 'Email', with: @merchant.email
    fill_in 'Password', with: @merchant.password

    click_on "Submit"
  end

  it 'shows my profile data, but I cannot edit the info' do

    expect(current_path).to eq(dashboard_path)
  
    expect(page).to have_content("Name: #{@merchant.name}")
    expect(page).to have_content("Address: #{@merchant.street}")
    expect(page).to have_content("#{@merchant.city}, #{@merchant.state} #{@merchant.zip}")
    expect(page).to have_content("Email: #{@merchant.email}")

    expect(page).not_to have_content("Edit")
    expect(page).not_to have_content("edit")
  end

  it 'shows a link to view my own items and I am redirected' do

    expect(current_path).to eq(dashboard_path)

    expect(page).to have_link("My Items")

    click_on("My Items")

    expect(current_path).to eq(dashboard_items_path)
  end
end
