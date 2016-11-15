require 'rails_helper'

describe Review, type: :model do
  it 'cannot have a rating greater than 5' do
    review = Review.new(rating: 6)
    expect(review).to have(1).error_on(:rating)
  end
end
