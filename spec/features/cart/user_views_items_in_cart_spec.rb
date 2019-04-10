require "rails_helper"

RSpec.describe 'As a visitor or registered user', type: :feature do
  scenario 'I see all items Ive added to my cart' do
    user = create(:user)
    @beer_1 = user.items.create(name: "Heineken", description: "Pale lager, 5%", item_price: 4.00, stock: 56, enabled: true, image: "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5d/Heineken.jpg/156px-Heineken.jpg")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit root_path

      within '#nav-bar' do
      click_on "Shop Beers"
      expect(current_path).to eq(items_path)
        end

      click_link "Heineken"
      expect(current_path).to eq(item_path(@beer_1))
      click_on "Add to Cart"
      click_on "Cart"

      expect(current_path).to eq(cart_path)


      expect(page).to have_content("Name: Heineken")
      expect(page).to have_content("Amount: 1")

  end
end
