require 'spec_helper'
require 'capybara'

feature "Creating goals#" do

  before(:each) do
    sign_up("testuser1")
  end

  it "should have a create goal button" do
    expect(page.find_button("Create Goal").visible?).to eq true
  end

  it "should show goals created so far for user" do
    create_public_goal("Win the lottery")
    expect(page).to have_content("Win the lottery")
  end

  it "allow user to click on each goal" do
    create_public_goal("Win the lottery")
    click_on "Win the lottery"
  end

  it "user can delete existing goal" do
    create_public_goal("Win the lottery")
    click_on "Delete"
    expect(page).not_to have_content("Win the lottery")
  end

  it "has link to index of all users' public goals" do
    create_public_goal("Win the lottery")
    click_on "Sign Out"
    sign_up("testuser2")
    create_public_goal("Another cool goal")
    click_on "Community Goals"
    expect(page).to have_content("Win the lottery")
    expect(page).to have_content("Another cool goal")
  end

end