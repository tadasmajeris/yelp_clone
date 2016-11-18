require "rails_helper"

describe Review, type: :model do
  it "is invalid if the rating > 5" do
    review = Review.new(rating:6)
    expect(review).to have(1).error_on(:rating)
  end

  # context "it should not allow multiple reviews from the same user" do
  #   it
  # end



end
