require 'rails_helper'

RSpec.describe 'User Profile Page' do
  before :each do
    @user = create(:user)
    @order_1 = create(:order)
    @order_2 = create(:order)
    @order_3 = create(:order)
  end
  describe 'a user has basic info available, no password ofcourse' do
    it 'has idenfication fields' do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
        visit profile_path

        expect(current_path).to eq(profile_path)

        expect(page).to have_content(@user.name)
        expect(page).to have_content(@user.email)
        end

    it 'has the user address' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit profile_path

      expect(current_path).to eq(profile_path)
      expect(page).to have_content(@user.street)
      expect(page).to have_content(@user.city)
      expect(page).to have_content(@user.state)
      expect(page).to have_content(@user.zip)

    end
    it 'has a link to edit info' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit profile_path

      click_on "Edit Info"

      expect(current_path).to eq(edit_user_path(@user))

    end
  end
  it 'a user can access their orders' do

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit profile_path

      click_on "My Orders"

      expect(current_path).to eq(profile_orders_path(@user))

  end

end

#carrying params through path helpers
