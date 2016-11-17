require 'rails_helper'

feature 'reviewing' do

  scenario 'allows users to leave a review using a form' do
    sign_up_and_sign_in
    create_restaurant
    leave_review('so so', 3)
    click_link 'Sign out'
    sign_up_and_sign_in(email: "anyone@gmail.com", password: "123456")
    leave_review('great', 5)
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('so so')
    expect(page).to have_content('Average rating: ★★★★☆')
  end
end
