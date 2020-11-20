require 'pg'
require_relative './comment'

class Bookmark
  attr_reader :id, :title, :url

  def initialize(id:, title:, url:)
    @id = id
    @title = title
    @url = url
  end

  def self.all
    result = DatabaseConnection.query('SELECT * FROM bookmarks;')
    result.map do |bookmark|
      Bookmark.new(id: bookmark['id'], title: bookmark['title'], url: bookmark['url'])
    end
  end

  def self.create(url:, title:)
    return false unless is_url?(url)

    result = DatabaseConnection.query("INSERT INTO bookmarks (title, url) VALUES ('#{title}', '#{url}') RETURNING id, title, url;")
    Bookmark.new(id: result[0]['id'], title: result[0]['title'], url: result[0]['url'])
  end

  def self.delete(id:)
    DatabaseConnection.query("DELETE FROM bookmarks WHERE id=#{id}")
    nil
  end

  def self.update(id:, url:, title:)
    result = DatabaseConnection.query("UPDATE bookmarks SET title='#{title}', url='#{url}' WHERE id=#{id} RETURNING id, url, title;")
    Bookmark.new(id: result[0]['id'], title: result[0]['title'], url: result[0]['url'])
  end

  def self.find(id:)
    result = DatabaseConnection.query("SELECT * FROM bookmarks WHERE id='#{id}';")
    Bookmark.new(id: result[0]['id'], title: result[0]['title'], url: result[0]['url'])
  end

  def comments
    result = DatabaseConnection.query("SELECT * FROM comments WHERE bookmark_id = #{id}")
    result.map { |comment| Comment.new(id: comment['id'], text: comment['text'], bookmark_id: comment['bookmark_id']) }
  end

  def add_tag(tag:)
    tag_database_id = DatabaseConnection.query("INSERT INTO tags (content) VALUES ('#{tag}') RETURNING id;")
    DatabaseConnection.query("INSERT INTO bookmark_tags (bookmark_id, tag_id) VALUES ('#{@id}', '#{tag_database_id[0]['id']}');")
  end

  def tags
    results = DatabaseConnection.query("SELECT tags.id, content FROM bookmark_tags INNER JOIN tags ON tags.id = bookmark_tags.tag_id WHERE bookmark_tags.bookmark_id = '#{@id}';")
    results.map { |tag| Tag.new(id: tag['id'], content: tag['content']) }
  end

  def self.is_url?(url)
    url =~ /\A#{URI::DEFAULT_PARSER.make_regexp(%w[http https])}\z/
  end
end
