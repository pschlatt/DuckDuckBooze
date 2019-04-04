require 'rails_helper'

RSpec.describe 'a visitor or registered user' do
  describe 'when visiting an items show page' do
    context 'when I click on the add to cart button' do
      before :each do
        @item = create(:item)
      end

      it 'as a visitor - this item is added to my cart, I am redirected to the items catalogue' do

        visit item_path(@item)

        click_on("Add to Cart")

        expect(current_path).to eq(items_path)
      end

      it 'as a visitor - it shows a flash confirmation message, and my cart in the nav bar increments' do

        visit item_path(@item)

        click_on("Add to Cart")

        expect(page).to have_content("You have added #{@item.name} to your cart")
        expect(page).to have_content("Cart: 1")

        visit item_path(@item)
        click_on("Add to Cart")

        expect(page).to have_content("You have added #{@item.name} to your cart")
        expect(page).to have_content("Cart: 2")
      end








      xit 'as a registered user this item is added to my cart, I am redirected to the items catalogue' do

        user = create(:user)

        visit item_path(@item)

        click_on("Add to Cart")

        expect(current_path).to eq(items_path)
      end
    end
  end
end


# As a visitor or registered user
# When I visit an item's show page from the items catalog
# I see a link or button to add this item to my cart
# And I click its link or button
# I am returned to the item index page
# I see a flash message indicating the item has been added to my cart
# The navigation bar increments my cart counter
