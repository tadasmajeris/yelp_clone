require "rails_helper"

describe "Restaurant", type: :model do
  it "is not valid with a name shorter than 3 chars" do
    restaurant = Restaurant.new(name: "kf")
    expect(restaurant).to have(1).error_on(:name)
    expect(restaurant).not_to be_valid
  end

  it "is not valid unless the name is unique" do
    user = User.create(email: 'joe@joe.com', password: 'joejoe', password_confirmation: 'joejoe')
    Restaurant.create(name: "Chicken Inn", user_id: user.id)
    restaurant = Restaurant.new(name: "Chicken Inn")
    expect(restaurant).to have(1).error_on :name
  end

  describe 'reviews' do
    describe 'build_with_user' do

      let(:user) { User.create email: 'joe@joe.com' }
      let(:restaurant) { Restaurant.create name: 'Cafe' }
      let(:params) { {rating: 5, thoughts: 'yum'} }

      subject(:review) { restaurant.reviews.build_with_user(params, user) }

      it 'builds a review' do
        expect(review).to be_a Review
      end

      it 'builds a review associated with the user' do
        expect(review.user).to eq user
      end
    end
  end

end
