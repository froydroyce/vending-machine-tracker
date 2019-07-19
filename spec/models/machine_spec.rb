require 'rails_helper'

RSpec.describe Machine, type: :model do
  describe 'validations' do
    it { should validate_presence_of :location }
    it { should belong_to :owner }
  end

  describe 'instance methods' do
    it "#average_price" do
      owner = Owner.create(name: "Sam's Snacks")
      dons  = owner.machines.create(location: "Don's Mixed Drinks")
      snickers = dons.snacks.create!(name: "Snickers", price: 2.99)
      lays = dons.snacks.create!(name: "Lay's", price: 1.99)

      expect(dons.average_price).to eq(2.49)
    end
  end
end
