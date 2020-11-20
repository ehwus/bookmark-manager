require 'tag'

describe Tag do
  it "initializes with ID and content" do
    test = Tag.new(id: 69, content: "Test content")
    expect(test.id).to eq(69)
    expect(test.content).to eq("Test content")
  end

  describe '.add_tag' do
    it "gives a tag to the bookmark" do
      bookmark = Bookmark.create(url: 'http://testbookmark.com', title: 'Test Bookmark')
      Tag.add_tag(tag_id: bookmark.id, value: "Interesting")
      expect(bookmark.tags.first.content).to include("Interesting")
    end
  end
end