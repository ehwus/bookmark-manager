require 'tag'

describe Tag do
  it "initializes with ID and content" do
    test = Tag.new(id: 69, content: "Test content")
    expect(test.id).to eq(69)
    expect(test.content).to eq("Test content")
  end
end