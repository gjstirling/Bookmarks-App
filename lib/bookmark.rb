# frozen_string_literal: true

require_relative 'database_connection'
require_relative 'comment'
# Documentation comment
class Bookmark
  def self.all
    result = DatabaseConnection.query('SELECT * FROM bookmarks')
    result.map do |bookmark|
      Bookmark.new(
        url: bookmark['url'],
        title: bookmark['title'],
        id: bookmark['id']
      )
    end
  end

  def self.create(url:, title:)
    return false unless is_url?(url)

    result = DatabaseConnection.query(
      'INSERT INTO bookmarks (url, title) VALUES($1, $2) RETURNING id, title, url;', [url, title]
    )
    Bookmark.new(id: result[0]['id'], title: result[0]['title'], url: result[0]['url'])
  end

  def self.delete(id:)
    DatabaseConnection.query(
      'DELETE FROM bookmarks WHERE id = $1', [id]
    )
  end

  def self.update(id:, url:, title:)
    result = DatabaseConnection.query(
      'UPDATE bookmarks SET url = $1, title = $2 WHERE id = $3 RETURNING id, url, title;', [url, title, id]
    )
    Bookmark.new(id: result[0]['id'], title: result[0]['title'], url: result[0]['url'])
  end

  def self.find(id:)
    result = DatabaseConnection.query(
      'SELECT * FROM bookmarks WHERE id = $1', [id]
    )
    Bookmark.new(id: result[0]['id'], title: result[0]['title'], url: result[0]['url'])
  end

  def comments(comment_class = Comment)
    comment_class.where(bookmark_id: id)
  end

  attr_reader :id, :title, :url

  def initialize(id:, title:, url:)
    @id = id
    @title = title
    @url = url
  end

  def self.is_url?(url)
    url =~ /\A#{URI::DEFAULT_PARSER.make_regexp(%w[http https])}\z/
  end
end
