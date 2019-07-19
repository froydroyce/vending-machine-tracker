require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'When I visit a snack show page' do
    before(:each) do
      @owner = Owner.create(name: "Sam's Snacks")
      @dons  = @owner.machines.create(location: "Don's Mixed Drinks")
      @tb  = @owner.machines.create(location: "Turing Basement")
      @snickers = Snack.create!(name: "Snickers", price: 2.99)
      @lays = Snack.create!(name: "Lay's", price: 1.99)
      @doritos = Snack.create!(name: "Lay's", price: 1.99)
      @dons.snacks << [@snickers, @lays]
      @tb.snacks << [@doritos, @lays, @snickers]
      visit snack_path(@snickers)
    end

    it "I see the name of that snack including the snacks:\n
    -price\n
    -list of locations with vending machines that carry the snack\n
    -average price for snacks in those vending machines\n
    -a count of the different kinds of items in that vending machine." do

      expect(page).to have_content(@snickers.name)
      expect(page).to have_content(@snickers.price)
      expect(page).to have_content(@dons.location)
      expect(page).to have_content(@tb.location)
      expect(page).to have_content(@dons.average_price.round(2))
      expect(page).to have_content(@tb.average_price.round(2))
      expect(page).to have_content(@dons.snacks.count)
      expect(page).to have_content(@tb.snacks.count)
    end
  end
end
