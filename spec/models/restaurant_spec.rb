require 'rails_helper'

describe Restaurant, type: :model do
  it 'is not valid with a name of less than three characters' do
    restaurant = Restaurant.new(name: 'kf')
    expect(restaurant).to have(1).error_on(:name)
    expect(restaurant).not_to be_valid
  end

  it 'must have a unique name' do
    Restaurant.create(name: 'Tavern')
    restaurant = Restaurant.new(name: 'Tavern')
    expect(restaurant).to have(1).error_on(:name)
  end
end
