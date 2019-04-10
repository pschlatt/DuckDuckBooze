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

      it 'as a registered user - this item is added to my cart, I am redirected to the items catalogue' do
        user = create(:user)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit item_path(@item)

        click_on("Add to Cart")

        expect(current_path).to eq(items_path)
      end

      it 'as a registered user - it shows a flash confirmation message, and my cart in the nav bar increments' do
        user = create(:user)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit item_path(@item)

        click_on("Add to Cart")

        expect(page).to have_content("You have added #{@item.name} to your cart")
        expect(page).to have_content("Cart: 1")

        visit item_path(@item)
        click_on("Add to Cart")

        expect(page).to have_content("You have added #{@item.name} to your cart")
        expect(page).to have_content("Cart: 2")
      end
    end
  end
end
