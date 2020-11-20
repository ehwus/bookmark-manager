class Tag
  attr_reader :id, :content
  def initialize(id:, content:)
    @id = id
    @content = content
  end

  def self.add_tag(tag_id:, value:)
    tag_database_id = DatabaseConnection.query("INSERT INTO tags (content) VALUES ('#{value}') RETURNING id;")
    DatabaseConnection.query("INSERT INTO bookmark_tags (bookmark_id, tag_id) VALUES ('#{tag_id}', '#{tag_database_id[0]['id']}');")
  end
end