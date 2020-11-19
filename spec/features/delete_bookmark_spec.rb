require 'capybara/rspec'

feature "delete bookmark" do
  scenario "it has a button to delete a bookmark" do
    Bookmark.create(url: "http://testbookmark.com", title: "Test Bookmark")
    visit('/bookmarks')
    expect(page).to have_button('Delete')
  end

  scenario "it actually deletes a bookmark" do
    Bookmark.create(url: "http://testbookmark.com", title: "Test Bookmark")
    visit('/bookmarks')
    click_button('Delete')
    expect(current_path).to eq '/bookmarks'
    expect(page).not_to have_link("Test Bookmark", href: "http://testbookmark.com")
  end
end