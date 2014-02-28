require 'spec_helper'
require 'capybara'

feature "signing up" do

  it "has a sign up page" do
    visit new_user_url
    expect(page).to have_content("Sign Up")
  end

  feature "signs up a user" do
    before(:each) do
      sign_up
    end

    it "should have sign in input boxes" do
      visit new_user_url
      expect(page).to have_content("Username")
      expect(page).to have_content("Password")
    end

    it "should show error at empty password" do
      visit new_user_url
      fill_in "Username", :with => "testuser"
      click_on "Sign Up"
      expect(page).to have_content("Password is too short")
    end

    it "should show error at empty username" do
      visit new_user_url
      fill_in "Password", :with => "password"
      click_on "Sign Up"
      expect(page).to have_content("Username can't be blank")
    end


    it "should redirect to the user page" do
      expect(page).to have_content("testuser")
    end
  end
end

feature "logging in" do
  it "shows username on the homepage after login" do
    sign_up
    visit new_session_url
    fill_in "Username", :with => "testuser"
    fill_in "Password", :with => "password"
    click_button "Sign In"
    expect(page).to have_content("testuser")
  end
end

feature "logging out" do
  it "begins with logged out state" do
    visit root_url
    expect(page).to have_content("Sign In")
    expect(page).to have_content("Sign Up")
  end

  it "doesn't show username on homepage after logout" do
    sign_up
    visit new_session_url
    fill_in "Username", :with => "testuser"
    fill_in "Password", :with => "password"
    click_button "Sign In"
    click_button "Sign Out"
    expect(page).not_to have_content("testuser")
  end

end
