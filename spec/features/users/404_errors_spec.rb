require 'rails_helper'

RSpec.describe '404 errors' do
  describe 'when a visitor tries to navigate' do
    it 'to any /profile path' do 
      visit '/profile'

      expect(page.status_code).to eq(404)
      expect(page).to have_content("The page you were looking for doesn't exist (404)")
    end 

    xit 'to any /profile path' do 
      visit '/profile'

      expect(page.status_code).to eq(404)
      expect(page).to have_content("The page you were looking for doesn't exist (404)")
    end 
  end 
end