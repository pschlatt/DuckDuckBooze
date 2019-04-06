require 'rails_helper'

RSpec.describe 'as a visitor attempting to log in - login path' do
  before :each do
    @reg_user = User.create(role: 1, enabled: false, name: "Sally Shopper", street: "123 Busy Way", city: "Denver", state: "CO", zip: "80222", email: "sally@gmail.com", password: "12345678")

    visit login_path
  end

  context 'if I submit invalid information' do
    it 'notifies me that my credentials were incorrect - but I am not told which ones - and I am redirected back to log in' do
      fill_in 'Email', with: @reg_user
      fill_in 'Password', with: 'incorrect'

      click_on "Submit"
      
      expect(page).to have_content("Invalid Credentials")
      expect(current_path).to eq(login_path)
    end
  end
end
