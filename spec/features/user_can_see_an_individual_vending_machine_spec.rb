require 'rails_helper'

RSpec.describe 'When a user visits a vending machine show page', type: :feature do
  before(:each) do
    @owner = Owner.create(name: "Sam's Snacks")
    @dons  = @owner.machines.create(location: "Don's Mixed Drinks")
    @snickers = @dons.snacks.create!(name: "Snickers", price: 2.99)
    @lays = @dons.snacks.create!(name: "Lay's", price: 1.99)
    visit machine_path(@dons)
  end

  scenario 'they see the location of that machine' do

    expect(page).to have_content("Don's Mixed Drinks Vending Machine")
  end

  scenario 'they see the name of all of the snacks associated with that vending machine along with their price' do

    expect(page).to have_content(@snickers.name)
    expect(page).to have_content(@snickers.price)
    expect(page).to have_content(@lays.name)
    expect(page).to have_content(@lays.price)
  end

  scenario 'they see an average price for all of the snacks in that machine' do

    expect(page).to have_content(@dons.average_price)
  end
end
