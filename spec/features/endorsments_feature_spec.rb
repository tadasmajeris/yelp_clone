require 'rails_helper'

feature 'endorsing reviews' do
  before do
    user = User.create(email: 'joe@joe.com', password: '123456', password_confirmation: '123456')
    restaurant = Restaurant.create(name: 'KFC', user_id: user.id)
    restaurant.reviews.create_with_user({rating: 3}, user)
  end

  scenario 'a user can endorse a review, which updates the count' do
    visit '/restaurants'
    click_link 'Endorse Review'
    expect(page).to have_content '1 endorsement'
  end
end
