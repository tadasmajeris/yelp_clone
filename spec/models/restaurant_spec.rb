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

      let(:user) { User.create email: 'joe@joe.com', password: '123456', password_confirmation: '123456' }
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

  describe '#average_rating' do

    context 'no reviews' do
      it 'returns "N/A" when there are no reviews' do
        restaurant = Restaurant.create(name: 'The Ivy')
        expect(restaurant.average_rating).to eq 'N/A'
      end
    end

    context '1 review' do
      it 'returns the rating' do
        user = User.create(email: 'joe@joe.com', password: '123456', password_confirmation: '123456')
        user2 = User.create(email: 'anyone@gmail.com', password: '123456', password_confirmation: '123456')
        restaurant = Restaurant.create(name: 'The Ivy', user_id: user2.id )
        restaurant.reviews.create_with_user({rating: 4}, user)
        expect(restaurant.average_rating).to eq 4
      end
    end
    context 'multiple reviews' do
      it 'returns the average' do
        user = User.create(email: 'joe@joe.com', password: '123456', password_confirmation: '123456')
        user2 = User.create(email: 'anyone@gmail.com', password: '123456', password_confirmation: '123456')
        restaurant = Restaurant.create(name: 'The Ivy', user_id: user.id )
        restaurant.reviews.create_with_user({rating: 1}, user)
        restaurant.reviews.create_with_user({rating: 5}, user2)
        expect(restaurant.average_rating).to eq 3
      end
    end
  end
end
