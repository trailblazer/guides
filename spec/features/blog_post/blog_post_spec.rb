require "rails_helper"

RSpec.feature "CRUD for BlogPost", :type => :feature do
  scenario "User creates a blog post" do
    visit "/blog_posts/new"

    # invalid
    fill_in "Title", :with => "Did you know?"
    click_button "Create Post"

    expect(page).to have_css("#blog_post_title,span.error")
  end
end
