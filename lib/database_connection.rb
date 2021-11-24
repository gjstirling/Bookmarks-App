require 'pg'

class DatabaseConnection
  
  def self.setup(dbname)
    @connection = PG.connect(dbname: dbname)
  end

  def self.connection
    @connection
  end

  def self.query(sql, params = [])
    p params
    @connection.exec_params(sql, params)
  end

end 