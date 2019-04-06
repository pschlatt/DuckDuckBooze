require 'rails_helper'

RSpec.describe '404 errors' do
  describe 'when a visitor tries to navigate' do
    it 'to any /profile path' do 
      visit '/profile'

      expect(page.status_code).to eq(404)
      expect(page).to have_content("The page you were looking for doesn't exist (404)")

      visit '/profile/orders'

      expect(page.status_code).to eq(404)
      expect(page).to have_content("The page you were looking for doesn't exist (404)")
    end 

    it 'to any /admin' do 
      visit '/admin/users'

      expect(page.status_code).to eq(404)
      expect(page).to have_content("The page you were looking for doesn't exist (404)")

      visit '/admin/users/1'

      expect(page.status_code).to eq(404)
      expect(page).to have_content("The page you were looking for doesn't exist (404)")

      visit '/admin/merchants/:id'

      expect(page.status_code).to eq(404)
      expect(page).to have_content("The page you were looking for doesn't exist (404)")

      visit '/admin/dashboard'

      expect(page.status_code).to eq(404)
      expect(page).to have_content("The page you were looking for doesn't exist (404)")
    end 
  end 
end