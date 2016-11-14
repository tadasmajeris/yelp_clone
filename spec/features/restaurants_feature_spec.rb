require 'rails_helper'

feature 'restaurants' do
  context 'no restaurants have been added' do

    scenario 'should display a prompt to add a restaurant' do
      visit ('/restaurants')
      expect(page).to have_content "Restaurant listings: There are currently no listings available"
      expect(page).to have_link "Add a restaurant"
    end
  end

context 'restaurants have been added' do
  before do
    Restaurant.create(name: 'Pizza Express')
  end
    scenario 'display restaurants' do
      visit ('/restaurants')
      expect(page).to have_content "Pizza Express"
      expect(page).not_to have_content "Restaurant listings: There are currently no listings available"
    end
  end

context 'creating restaurants' do
  scenario 'prompts a user to fill out a form, then displays the new restaurant' do
    visit '/restaurants'
    click_link 'Add a restaurant'
    fill_in 'name', with: 'Pizza Hut'
    fill_in 'rating', with: '4'
    click_button 'Submit'
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content 'Pizza Hut, Rating: 4'
  end
end

end
