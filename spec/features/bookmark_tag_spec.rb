require 'capybara/rspec'

feature "Bookmark Tags" do
  scenario "Tags are displayed" do
    bookmark = Bookmark.create(url: 'http://www.makersacademy.com', title: 'Makers Academy')
    bookmark.add_tag(tag: "Sexy")
    visit('/bookmarks')
    expect(page).to have_content("Sexy")
  end

  scenario "Users can add tags that are then displayed" do
    bookmark = Bookmark.create(url: 'http://www.makersacademy.com', title: 'Makers Academy')
    visit('/bookmarks')
    first('.bookmark-options').click_button('Add Tag')
    fill_in('tag', with: "Sexy")
    click_button('Submit')
    expect(page).to have_content("Sexy")
    expect(current_path).to eq('/bookmarks')
  end
end