require 'bookmark'

describe Bookmark do
  describe '.all' do
    it 'returns all bookmarks' do
      bookmark = Bookmark.create(url: 'http://www.makersacademy.com', title: 'Makers Academy')
      Bookmark.create(url: 'http://www.destroyallsoftware.com', title: 'Destroy All Software')
      Bookmark.create(url: 'http://www.google.com', title: "Google")

      bookmarks = Bookmark.all

      expect(bookmarks.length).to eq(3)
      expect(bookmarks.first).to be_a Bookmark
      expect(bookmarks.first.id).to eq(bookmark.id)
      expect(bookmarks.first.url).to eq('http://www.makersacademy.com')
    end
  end

  describe ".create" do
    it "creates a new bookmark" do
      bookmark = Bookmark.create(url: "http://testbookmark.com", title: "Test Bookmark")
      expect(bookmark.url).to eq("http://testbookmark.com")
      expect(bookmark.title).to eq("Test Bookmark")
    end
  end

  describe ".delete" do
    it "deletes a bookmark by ID" do
      bookmark = Bookmark.create(url: "http://testbookmark.com", title: "Test Bookmark")
      id = bookmark.id
      Bookmark.delete(id: id)
      expect(Bookmark.all.length).to eq(0)
    end

    it "only deletes one bookmark" do
      Bookmark.create(url: "http://testbookmark.com", title: "Test Bookmark")
      test = Bookmark.create(url: "http://testbookmark.com", title: "Test Bookmark 2: Electric Boogaloo")
      Bookmark.delete(id: test.id)
      expect(Bookmark.all.length).to eq(1)
    end
  end

  describe ".update" do
    it "updates a bookmark by ID" do
      bookmark = Bookmark.create(url: "http://testbookmark.com", title: "Test Bookmark")
      updated_bookmark = Bookmark.update(id: bookmark.id, url: 'www.makersacademy.com', title: 'Makers Academy')
      expect(updated_bookmark.title).to eq('Makers Academy')
      expect(updated_bookmark.url).to eq('www.makersacademy.com')
    end
  end
end