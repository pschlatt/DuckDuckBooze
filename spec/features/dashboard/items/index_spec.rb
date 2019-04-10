require 'rails_helper'

RSpec.describe 'Merchant Items Index Page', type: :feature do
  describe 'as a merchant visiting my items page' do
    before :each do
      @merch = create(:merchant)
      @user = create(:user)

      @item_1 = create(:item, user_id: @merch.id, stock: 75)
      @item_2 = create(:item, user_id: @merch.id, stock: 85)
      @item_3 = create(:item, user_id: @merch.id, stock: 105, enabled: false)

      @order_1 = create(:order, user_id: @user.id)

      @order_item_1 = OrderItem.create(quantity: 6, order_price: 2.0, order_id: @order_1.id, item_id: @item_1.id)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merch)

      visit dashboard_items_path
    end

    it 'shows a link to add new items to the system' do
      expect(page).to have_link("Add New Item")
    end

    it 'shows all items that I have added to the system including - id, name, image, price, inventory, and edit link' do
      within "#item-#{@item_1.id}" do
        expect(page).to have_content("ID: #{@item_1.id}")
        expect(page).to have_content(@item_1.name)
        expect(page).to have_content("Price: #{@item_1.item_price}")
        expect(page).to have_content("Stock: #{@item_1.stock}")
        expect(page).to have_link("Edit")

        within ".thumbnail" do
          expect(page).to have_xpath("//img[@src='#{@item_1.image}']")
        end
      end

      within "#item-#{@item_2.id}" do
        expect(page).to have_content("ID: #{@item_2.id}")
        expect(page).to have_content(@item_2.name)
        expect(page).to have_content("Price: #{@item_2.item_price}")
        expect(page).to have_content("Stock: #{@item_2.stock}")
        expect(page).to have_link("Edit")

        within ".thumbnail" do
          expect(page).to have_xpath("//img[@src='#{@item_2.image}']")
        end
      end
    end

    it 'shows a link to delete the item if no user has ever ordered this item' do
      within "#item-#{@item_1.id}" do
        expect(page).to_not have_link("Delete")
      end

      within "#item-#{@item_2.id}" do
        expect(page).to have_link("Delete")
      end
    end

    it 'shows an enable link for a disabled item, and a disable link for an enabled item' do
      within "#item-#{@item_1.id}" do
        expect(page).to_not have_link("Enable")
        expect(page).to have_link("Disable")
      end

      within "#item-#{@item_3.id}" do
        expect(page).to have_link("Enable")
        expect(page).to_not have_link("Disable")
      end
    end

    context 'when I click an enable button next to an item' do
      it 'return me to my items page, I see a confirmation message, and I see that the item is now enabled for sale' do

        within "#item-#{@item_3.id}" do
          click_on "Enable"
        end

        expect(current_path).to eq(dashboard_items_path)
        expect(page).to have_content("#{@item_3.name} now available for sale!")

        @item_3.reload
        expect(@item_3.enabled?).to eq(true)

        within "#item-#{@item_3.id}" do
          expect(page).to_not have_link("Enable")
          expect(page).to have_link("Disable")
        end
      end
    end

    context 'when I click a disable button next to an item' do
      it 'return me to my items page, I see a confirmation message, and I see that the item is now disabled' do

        within "#item-#{@item_1.id}" do
          click_on "Disable"
        end

        expect(current_path).to eq(dashboard_items_path)
        expect(page).to have_content("#{@item_1.name} no longer available for sale")

        @item_1.reload
        expect(@item_1.enabled?).to eq(false)

        within "#item-#{@item_1.id}" do
          expect(page).to have_link("Enable")
          expect(page).to_not have_link("Disable")
        end
      end
    end

  context 'when I click a delete button next to an item' do
    it 'return me to my items page, I see a confirmation message, and I no longer see the item on my page' do

      expect(Item.all).to eq([@item_1, @item_2, @item_3])

      within "#item-#{@item_2.id}" do
        click_on "Delete"
      end

      expect(current_path).to eq(dashboard_items_path)
      expect(page).to have_content("#{@item_2.name} has been deleted")

      expect(page).to_not have_selector('div', id: "item-#{@item_2.id}")
      expect(Item.all).to eq([@item_1, @item_3])
    end
  end

    context 'when I click the Add New Item link' do
      it 'shows a form which must be filled out with valid information' do
        click_on "Add New Item"

        expect(current_path).to eq(new_dashboard_item_path)

        expect(page).to have_field("Name")
        expect(page).to have_field("Description")
        expect(page).to have_field("Image URL")
        expect(page).to have_field("Item Price")
        expect(page).to have_field("Inventory")

        expect(page).to have_button "Create Item"
      end

      it 'when filled out with valid info, redirects to my items page where I see the item, and a confirmation message' do
        click_on "Add New Item"

        expect(current_path).to eq(new_dashboard_item_path)

        new_item = Item.new(name: "Mickeys", description: "Malt Liquor", item_price: 2.00, stock: 12)

        fill_in "Name", with: new_item.name
        fill_in "Description", with:new_item.description
        fill_in "Item Price", with: new_item.item_price
        fill_in "Inventory", with: new_item.stock

        click_on "Create Item"

        expect(current_path).to eq(dashboard_items_path)
        expect(page).to have_content("#{new_item.name} has been added!")
        expect(new_item.enabled?).to eq(true)

        expect(page).to have_content(" - #{new_item.name}")
        expect(page).to have_content("Price: #{new_item.item_price}")
        expect(page).to have_content("Stock: #{new_item.stock}")
      end

      it 'when filled out with invalid info, I am notified of what needs to be fixed, and I see the form again' do
        click_on "Add New Item"

        expect(current_path).to eq(new_dashboard_item_path)

        new_item = Item.new(name: "Mickeys", description: "Malt Liquor", item_price: 2.00, stock: 12)

        fill_in "Item Price", with: new_item.item_price
        fill_in "Inventory", with: new_item.stock

        click_on "Create Item"

        expect(page).to have_content("Name can't be blank")
        expect(page).to have_content("Description can't be blank")
        
        expect(find_field("Item Price").value).to eq("#{new_item.item_price}")
        expect(find_field("Inventory").value).to eq("#{new_item.stock}")

        expect(current_path).to eq(dashboard_items_path)

        fill_in "Name", with: new_item.name
        fill_in "Description", with:new_item.description
        fill_in "Item Price", with: 0.00
        fill_in "Inventory", with: -2

        click_on "Create Item"

        expect(page).to have_content("Stock must be greater than 0")
        expect(page).to have_content("Item price must be greater than 0.0")

        expect(find_field("Name").value).to eq("#{new_item.name}")
        expect(find_field("Description").value).to eq("#{new_item.description}")
        expect(find_field("Item Price").value).to eq("0.0")
        expect(find_field("Inventory").value).to eq("-2")

        expect(current_path).to eq(dashboard_items_path)
      end
    end
  end
end 