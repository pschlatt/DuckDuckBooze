require 'rails_helper'
# As a registered user, merchant, or admin
# When I visit the login path
# If I am a regular user, I am redirected to my profile page
# If I am a merchant user, I am redirected to my merchant dashboard page
# If I am an admin user, I am redirected to the home page of the site
# And I see a flash message that tells me I am already logged in

# visit login_path which goes to sessions#new
# fill in form for logging in and submit (POST)
# submission to (sessions#create)
# find user by username from params
# authenticate user via method in User model
# set session[:user_id] to user.id
# case user.id.role OR session[:user_id].role
# when 1
#   redirect_to profile_path(user.id)
# when 2
#   redirect_to dashboard_path(user.id)
# when 3
#   redirect_to root_path
# end


RSpec.describe "a user who has already logged in", type: :feature do
  before_each do
    @user_11 = User.create(role: 1, enable_disable: 0, name: "Sally Shopper", street: "123 Busy Way", city: "Denver", state: "CO", zip: "80222", email: "sally@gmail.com", password: "12345678")
    @user_21 = User.create(role: 2, enable_disable: 0, name: "Mike Merchant", street: "1 Old Street", city: "Golden", state: "CO", zip: "80403", email: "mike@gmail.com", password: "password")
    @user_31 = User.create(role: 3, enable_disable: 0, name: "Aaron Admin", street: "1 Old Street", city: "Golden", state: "CO", zip: "80403", email: "aaron@gmail.com", password: "password")
  end

  it "registered user goes to profile page" do

    visit login_path

    fill_in :email, with: @user_11.email
    fill_in :password, with: @user_11.password
    click_on "Submit"

    visit login_path

    expect(current_page).to eq(profile_path(@user_11))
    expect(page).to have_content("You are already logged in.")
  end

  it "merchant goes to dashboard" do

    visit login_path

    fill_in :email, with: @user_21.email
    fill_in :password, with: @user_21.password
    click_on "Submit"

    visit login_path

    expect(current_page).to eq(dashboard_path(@user_21))
    expect(page).to have_content("You are already logged in.")
  end

  it "admin goes to root_path" do

    visit login_path

    fill_in :email, with: @user_31.email
    fill_in :password, with: @user_31.password
    click_on "Submit"

    visit login_path

    expect(current_page).to eq(root_path)
    expect(page).to have_content("You are already logged in.")
  end
end
