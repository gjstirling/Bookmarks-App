# frozen_string_literal: true

require 'pg'
# documentation comment
class DatabaseConnection
  def self.setup(dbname)
    @connection = PG.connect(dbname: dbname)
  end

  def self.connection
    @connection
  end

  def self.query(sql, params = [])
    @connection.exec_params(sql, params)
  end
end
