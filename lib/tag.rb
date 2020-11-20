class Tag
  attr_reader :id, :content
  def initialize(id:, content:)
    @id = id
    @content = content
  end
end