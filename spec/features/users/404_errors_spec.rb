require 'rails_helper'

RSpec.describe '404 errors' do
  describe 'when a visitor tries to navigate' do
    it 'to any /profile path' do 
      visit '/profile'

      expect(page.status_code).to eq(404)
      expect(page).to have_content("The page you were looking for doesn't exist (404)")

      visit '/profile/edit'

      expect(page.status_code).to eq(404)
      expect(page).to have_content("The page you were looking for doesn't exist (404)")

      visit '/profile/orders'

      expect(page.status_code).to eq(404)
      expect(page).to have_content("The page you were looking for doesn't exist (404)")
    end 

    it 'to any /admin path' do 
      visit '/admin/users'

      expect(page.status_code).to eq(404)
      expect(page).to have_content("The page you were looking for doesn't exist (404)")

      visit '/admin/users/1'

      expect(page.status_code).to eq(404)
      expect(page).to have_content("The page you were looking for doesn't exist (404)")

      visit '/admin/merchants/1'

      expect(page.status_code).to eq(404)
      expect(page).to have_content("The page you were looking for doesn't exist (404)")

      visit '/admin/dashboard'

      expect(page.status_code).to eq(404)
      expect(page).to have_content("The page you were looking for doesn't exist (404)")
    end 

    it 'to any /dashboard path' do 
      visit '/dashboard'

      expect(page.status_code).to eq(404)
      expect(page).to have_content("The page you were looking for doesn't exist (404)")

      visit '/dashboard/items'

      expect(page.status_code).to eq(404)
      expect(page).to have_content("The page you were looking for doesn't exist (404)")

      visit '/dashboard/items/1'

      expect(page.status_code).to eq(404)
      expect(page).to have_content("The page you were looking for doesn't exist (404)")
    end 
  end 

  describe 'when a registered user tries to navigate' do
    before :each do 
      @reg_user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@reg_user)
    end 

    it 'to any /dashboard path' do 
      visit '/dashboard'

      expect(page.status_code).to eq(404)
      expect(page).to have_content("The page you were looking for doesn't exist (404)")

      visit '/dashboard/items'

      expect(page.status_code).to eq(404)
      expect(page).to have_content("The page you were looking for doesn't exist (404)")

      visit '/dashboard/items/1'

      expect(page.status_code).to eq(404)
      expect(page).to have_content("The page you were looking for doesn't exist (404)")
    end 

    it 'to any /admin path' do 
      reg_user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(reg_user)

      visit '/admin/users'

      expect(page.status_code).to eq(404)
      expect(page).to have_content("The page you were looking for doesn't exist (404)")

      visit '/admin/users/1'

      expect(page.status_code).to eq(404)
      expect(page).to have_content("The page you were looking for doesn't exist (404)")

      visit '/admin/merchants/1'

      expect(page.status_code).to eq(404)
      expect(page).to have_content("The page you were looking for doesn't exist (404)")

      visit '/admin/dashboard'

      expect(page.status_code).to eq(404)
      expect(page).to have_content("The page you were looking for doesn't exist (404)")
    end 
  end
  
  describe 'when a merchant tries to navigate' do
    before :each do 
      @merchant = create(:merchant)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant)
    end 

    it 'to any /profile path' do 
      visit '/profile'

      expect(page.status_code).to eq(404)
      expect(page).to have_content("The page you were looking for doesn't exist (404)")
      
      visit '/profile/edit'

      expect(page.status_code).to eq(404)
      expect(page).to have_content("The page you were looking for doesn't exist (404)")

      visit '/profile/orders'

      expect(page.status_code).to eq(404)
      expect(page).to have_content("The page you were looking for doesn't exist (404)")
    end 

    it 'to any /admin path' do 
      visit '/admin/users'

      expect(page.status_code).to eq(404)
      expect(page).to have_content("The page you were looking for doesn't exist (404)")

      visit '/admin/users/1'

      expect(page.status_code).to eq(404)
      expect(page).to have_content("The page you were looking for doesn't exist (404)")

      visit '/admin/merchants/1'

      expect(page.status_code).to eq(404)
      expect(page).to have_content("The page you were looking for doesn't exist (404)")

      visit '/admin/dashboard'

      expect(page.status_code).to eq(404)
      expect(page).to have_content("The page you were looking for doesn't exist (404)")
    end 

    it 'to any /cart path' do 
      visit '/cart'

      expect(page.status_code).to eq(404)
      expect(page).to have_content("The page you were looking for doesn't exist (404)")
    end 
  end 

  describe 'when an admin tries to navigate' do
    before :each do
      @admin = create(:admin)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

    end 
    it 'to any /profile path' do 
      visit '/profile'

      expect(page.status_code).to eq(404)
      expect(page).to have_content("The page you were looking for doesn't exist (404)")

      visit '/profile/edit'

      expect(page.status_code).to eq(404)
      expect(page).to have_content("The page you were looking for doesn't exist (404)")

      visit '/profile/orders'

      expect(page.status_code).to eq(404)
      expect(page).to have_content("The page you were looking for doesn't exist (404)")
    end 

    it 'to any /dashboard path' do 
      visit '/dashboard'

      expect(page.status_code).to eq(404)
      expect(page).to have_content("The page you were looking for doesn't exist (404)")

      visit '/dashboard/items'

      expect(page.status_code).to eq(404)
      expect(page).to have_content("The page you were looking for doesn't exist (404)")

      visit '/dashboard/items/1'

      expect(page.status_code).to eq(404)
      expect(page).to have_content("The page you were looking for doesn't exist (404)")
    end 

    it 'to any /cart path' do 
      visit '/cart'

      expect(page.status_code).to eq(404)
      expect(page).to have_content("The page you were looking for doesn't exist (404)")
    end 
  end 
end