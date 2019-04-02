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

    it { should validate_uniqueness_of :email}
    it { should validate_inclusion_of(:enabled).in_array([true, false])}

    # it { should validate_numericality_of :role}
    # it { should validate_inclusion_of(:role).in_array([0,1,2,3])}
  end

  describe 'Relationships' do
    it { should have_many :items} #merchants
    it { should have_many :orders}
  end
end
