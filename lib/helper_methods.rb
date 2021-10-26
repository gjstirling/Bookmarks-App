def connect_to_db 
  if ENV['RACK_ENV'] == 'test'
    return PG.connect(dbname: 'bookmark_manager_test')
  else
    return PG.connect(dbname: 'bookmark_manager')
  end
end 