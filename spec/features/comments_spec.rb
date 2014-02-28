require 'spec_helper'
require 'capybara'

feature "Links should have comments" do
  before(:each) do
    populate_community_goal
  end


  it "should have a comment submission field" do
    expect(page).to have_content("Add a comment")
  end

  it "should allow users to comment on public goals" do
    visit goals_url
    click_on "Win the lottery"
    fill_in "Comment", :with => "A comment"
    click_on "Submit"
    expect(page).to have_content("A comment")
  end

  it "should allow users to comment on other users" do
    other_user = User.find_by_username("testuser1")
    visit user_url(other_user)
    fill_in "User Comments", :with => "A user comment"
    click_on "Submit"
    expect(page).to have_content("A user comment")
  end
end