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
