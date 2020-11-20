require 'capybara/rspec'

feature 'Adding a new bookmark' do
  scenario 'A user can add a bookmark to Bookmark Manager' do
    visit('/bookmarks')
    fill_in('url', with: 'http://www.testbookmark.com')
    fill_in('title', with: 'Test Bookmark')
    click_button('Submit')

    expect(page).to have_link('Test Bookmark', href: 'http://www.testbookmark.com')
  end

  scenario "a user can't give an invalid URL" do
    visit('/bookmarks')
    fill_in('url', with: 'Not a URL')
    fill_in('title', with: 'Not a URL')
    click_button('Submit')

    expect(page).not_to have_content 'Not a URL'
    expect(page).to have_content 'Please enter a valid URL.'
  end
end
