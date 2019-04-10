require "rails_helper"

describe 'on the cart page' do
  it 'shows no items in the cart for user' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit cart_path

    expect(page).to have_content("My cart is empty")
    expect(page).to_not have_link("Empty Cart")
  end

  it 'shows no items in the cart for visitor' do
    visit cart_path

    expect(page).to have_content("My cart is empty")
    expect(page).to_not have_link("Empty Cart")
  end
end
