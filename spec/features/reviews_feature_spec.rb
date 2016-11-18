require 'rails_helper'

feature 'reviewing' do

  scenario 'allows users to leave a review using a form' do
    sign_up
    add_restaurant
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in "Thoughts", with: "so so"
    select '3', from: 'Rating'
    click_button 'Leave Review'

     expect(current_path).to eq '/restaurants'
     expect(page).to have_content('so so')
  end

  scenario 'allows users to leave a review using a form' do
    sign_up
    add_restaurant
    leave_review('so so', 3)
    sign_out_and_sign_up_as_another
    leave_review('great', 5)
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('so so')
    expect(page).to have_content('Average rating: ★★★★☆')
  end
end
