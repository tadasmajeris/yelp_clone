require 'rails_helper'

feature 'restaurants' do
  context 'no restaurants have been added' do
    scenario "should prompt to add a restaurant" do
      visit "/restaurants"
      expect(page).to have_content("No restaurants yet")
      expect(page).to have_link("Add a restaurant")
    end

  context 'restaurants have been added' do
    before do
      Restaurant.create(name:"KFC")
    end
    scenario 'display restaurants' do
      visit "/restaurants"
      expect(page).to have_content("KFC")
      expect(page).not_to have_content("No restaurants yet")
    end

    context "addin a restaurant" do
      scenario "prompts user to complete a form and then displays the new restaurant" do
        visit "/restaurants"
        click_link("Add a restaurant")
        fill_in("Name", with: "KFC")
        # fill_in("rating", with: "3")
        click_button("Create Restaurant")
        # expect(page).to have_content("Restaurant successfully added")
        expect(page).to have_content("KFC")
        expect(current_path).to eq("/restaurants")
      end
    end

    context "viewing restaurants" do
      let!(:kfc){Restaurant.create(name: "KFC")}
      scenario "Lets a user view a restaurant" do
        visit "/restaurants"
        click_link("KFC")
        expect(page).to have_content("KFC")
        expect(current_path).to eq "/restaurants/#{KFC.id}"
      end
    end

  end

  end
end
