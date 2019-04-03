require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :name}
    it { should validate_presence_of :street}
    it { should validate_presence_of :city}
    it { should validate_presence_of :state}
    it { should validate_presence_of :zip}
    it { should validate_presence_of :email}
    it { should validate_presence_of :password}
    it { should validate_presence_of :role}
    it { should validate_inclusion_of(:enabled).in_array([true, false])}

    it { should validate_uniqueness_of :email}
    it { should validate_inclusion_of(:enabled).in_array([true, false])}
  end

  describe 'Relationships' do
    it { should have_many :items} #merchants
    it { should have_many :orders}
  end

  describe "roles" do
    it "can be created as an admin" do 
      @user = create(:user)
      @user.update(role: 3)
      
      expect(@user.role).to eq("admin")
      expect(@user.admin?).to be_truthy
    end

    it "can be created as an merchant" do 
      @user = create(:user)
      @user.update(role: 2)

      expect(@user.role).to eq("merchant")
      expect(@user.merchant?).to be_truthy
    end

    it "can be created as an registered_user" do 
      @user = create(:user)
      @user.update(role: 1)

      expect(@user.role).to eq("registered_user")
      expect(@user.registered_user?).to be_truthy
    end
  end
end
