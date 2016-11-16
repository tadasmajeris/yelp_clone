require "rails_helper"

feature "Users can sign in and out" do
  context "user not signed in and on hompage" do
    it "should see a signin and sign up link" do
      visit('/')
      expect(page).to have_link('Sign in')
      expect(page).to have_link('Sign up')
    end

    it "should not see sign out link" do
      visit("/")
      expect(page).not_to have_link "Sign out"
    end
  end

  context "user signed in on homepage" do
    before do
      visit "/"
      click_link "Sign up"
      fill_in "Email", with: "g@b.com"
      fill_in "Password", with: "123456"
      fill_in "Password confirmation", with: "123456"
      click_button "Sign up"
    end
    it "should see sign out link" do
      visit "/"
      expect(page).to have_link "Sign out"
    end

    it "should not see a signin and sign up link" do
      visit('/')
      expect(page).not_to have_link('Sign in')
      expect(page).not_to have_link('Sign up')
    end

  end

end

feature "user not signed in" do
  before do
    @restaurant = Restaurant.create(name: "Cafe del Mar", description: "On the beach al fresco")
  end
  scenario "cannot edit restaurant" do
    visit "/restaurants/#{@restaurant.id}/edit"
    expect(page).not_to have_css("form.edit_restaurant")
    expect(page).to have_css("form.new_user")
    page.driver.submit :patch, "/restaurants/#{@restaurant.id}", {"restaurant"=>{"name"=>"xyz", "description"=>"123"}}
    expect(Restaurant.first.name).not_to eq "xyz"
  end

  scenario "cannot delete restaurant" do
    expect { page.driver.delete "/restaurants/#{@restaurant.id}" }.not_to change(Restaurant, :count)
  end

  scenario "cannot add a restaurant" do
    visit "/restaurants/new"
    expect {page.driver.submit :post, restaurants_path, {"restaurant"=>{"name"=>"xyz", "description"=>"123"}}
     }.not_to change(Restaurant, :count)
    expect(page).not_to have_css("form.new_restaurant")
    expect(page).to have_css("form.new_user")
  end

  scenario "cannot create reviews" do
    visit "/restaurants/#{@restaurant.id}/reviews/new"
    expect(page).not_to have_css("form.new_review")
    expect(page).to have_css("form.new_user")
  end

end
