# frozen_string_literal: true

require 'pg'

def persisted_data(id:)
  connection = PG.connect(dbname: 'bookmark_manager_test')
  connection.query(
    'SELECT * FROM bookmarks WHERE id = $1;', [id]
  )
end

def clear_test_database
  connection = PG.connect(dbname: 'bookmark_manager_test')
  connection.exec('TRUNCATE bookmarks, comments RESTART IDENTITY;')
end
