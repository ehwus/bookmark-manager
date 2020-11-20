require 'database_connection'

describe DatabaseConnection do
  it "connects to a database" do
    expect(PG).to receive(:connect).with(dbname: 'bookmark_manager_test')
    DatabaseConnection.setup('bookmark_manager_test')
  end

  it "persists the connection" do
    connection = DatabaseConnection.setup('bookmark_manager_test')
    expect(connection).to eq(DatabaseConnection.connection)
  end

  it "sends queries for execution" do
    connection = DatabaseConnection.setup('bookmark_manager_test')
    expect(connection).to receive(:exec).with("SELECT * FROM bookmarks;")
    DatabaseConnection.query('SELECT * FROM bookmarks;')
  end
end