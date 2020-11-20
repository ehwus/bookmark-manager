require 'comment'
require 'bookmark'

describe Comment do
  describe '.create' do
    it 'creates a new comment' do
      bookmark = Bookmark.create(url: 'http://www.makersacademy.com', title: 'Makers Academy')
      comment = Comment.create(text: 'This is a test comment', bookmark_id: bookmark.id)
      result = DatabaseConnection.query("SELECT * FROM comments WHERE id = '#{comment.id}';")
      expect(result.first['id']).to eq(comment.id)
      expect(result.first['bookmark_id']).to eq(bookmark.id)
      expect(result.first['text']).to eq(comment.text)
    end
  end
end
