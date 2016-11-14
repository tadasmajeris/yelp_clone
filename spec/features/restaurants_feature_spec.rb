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
      fill_in 'Name', with: 'Pizza Hut'
      click_button 'Create Restaurant'
      expect(current_path).to eq '/restaurants'
      expect(page).to have_content 'Pizza Hut'
    end
  end

  context 'viewing restaurants' do
    let!(:dixy_chicken){ Restaurant.create(name: 'Dixy Chicken', description: "Dee fried 'chicken'") }

    scenario 'lets a user view a restaurant' do
      visit '/restaurants'
      click_link 'Dixy Chicken'
      expect(current_path).to eq "/restaurants/#{dixy_chicken.id}"
      expect(page).to have_content 'Dixy Chicken'
    end
  end

  context 'editing restaurants' do
    let!(:dixy_chicken){ Restaurant.create(name: 'Dixy Chicken', description: "Dee fried 'chicken'") }

    scenario 'let a user edit a restaurant' do
      visit '/restaurants'
      click_link 'Edit Dixy Chicken'
      fill_in 'Name', with: 'Chicken Cottage'
      fill_in 'Description', with: "Deep fried 'chicken'"
      click_button 'Update Restaurant'
      expect(current_path).to eq '/restaurants'
      expect(page).to have_content 'Chicken Cottage'
    end
  end

  context 'deleting restaurants' do

    before { Restaurant.create name: 'Devonshire Chippy', description: 'The best chips in all of Sheffield!' }

    scenario 'removes a restaurant when a user clicks a delete link' do
      visit '/restaurants'
      click_link 'Delete Devonshire Chippy'
      expect(page).not_to have_content 'Devonshire Chippy'
      expect(page).to have_content 'Restaurant deleted successfully'
    end
  end

end
