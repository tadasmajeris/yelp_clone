require 'rails_helper'

feature 'restaurants' do
  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'restaurants have been added' do
    before do
      sign_up
      add_restaurant
    end

    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content('KFC')
      expect(page).not_to have_content('No restaurants yet')
    end
  end

  context 'creating restaurants' do

    before do
      sign_up
    end

    scenario 'prompts user to fill out a form, then displays the new restaurant' do
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'KFC'
      click_button 'Create Restaurant'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq '/restaurants'
    end

    scenario 'adding image to a restaurant' do
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'KFC'
      page.attach_file('restaurant_image', Rails.root + 'public/rest.jpg')
      click_button 'Create Restaurant'
      expect(page).to have_css('img')
    end

    scenario 'restaurants cannot be added if user is not signed in' do
      sign_out
      visit '/'
      click_link 'Add a restaurant'
      expect(page).not_to have_content 'Name'
      expect(page).to have_content 'You need to sign in or sign up before continuing.'
    end
  end

  context 'an invalid restaurant' do
    before do
      sign_up
    end
      scenario 'does not let you submit a name that is too short' do
        visit '/restaurants'
        click_link 'Add a restaurant'
        fill_in 'Name', with: 'kf'
        click_button 'Create Restaurant'
        expect(page).not_to have_css 'h2', text: 'kf'
        expect(page).to have_content 'error'
      end
    end

  context 'viewing restaurants' do
    let!(:kfc){ Restaurant.create(name:'KFC') }

    scenario 'can click on a restaurant title and see more details' do
      sign_up
      add_restaurant
      visit '/restaurants'
      click_link 'KFC'
      # expect(current_path).to eq "/restaurants/#{kfc.id}"
      expect(page).to have_content 'KFC'
    end
  end

  context 'editing restaurants' do
    before do
      sign_up
      add_restaurant
    end

    scenario 'let a user edit a restaurant' do
      visit '/restaurants'
      click_link 'Edit KFC'
      fill_in 'Name', with: 'Kentucky Fried Chicken'
      fill_in 'Description', with: 'Deep fried goodness'
      click_button 'Update Restaurant'
      expect(page).to have_content 'Kentucky Fried Chicken'
      expect(page).to have_content 'Deep fried goodness'
      expect(current_path).to eq '/restaurants'
    end
  end

  context 'deleting restaurants' do
    before do
      sign_up
      add_restaurant
    end

    scenario 'removes a restaurant when a user clicks a delete link' do
      visit '/restaurants'
      click_link 'Delete KFC'
      expect(page).not_to have_content 'KFC'
      expect(page).to have_content 'Restaurant deleted successfully'
    end
  end


end
