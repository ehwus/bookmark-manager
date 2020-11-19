require 'pg'

def setup_test_database
  puts "\nSetting up test database..."

  connection = PG.connect(dbname: 'bookmark_manager_test')
  connection.exec("TRUNCATE bookmarks;")
end