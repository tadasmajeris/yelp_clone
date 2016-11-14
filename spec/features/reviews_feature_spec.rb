require 'rails_helper'

feature 'reviewing' do
  before { Restaurant.create name: "Greggs", description: "The festive bake is the best thing about Christmas" }

  scenario 'allows users to leave a review using a form' do
    visit '/restaurants'
    click_link 'Review Greggs'
    fill_in "Thoughts", with: "I <3 the Greggsnut"
    select '5', from: 'Rating'
    click_button 'Leave Review'

    expect(current_path).to eq '/restaurants'

    click_link 'Greggs'    
    expect(page).to have_content 'I <3 the Greggsnut'
  end
end
