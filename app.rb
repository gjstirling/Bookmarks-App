# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/reloader'
require './lib/bookmark'
require './database_connection_setup'
require 'uri'
require 'sinatra/flash'
# Documentation comment
class BookmarkManager < Sinatra::Base
  enable :sessions, :method_override
  register Sinatra::Flash

  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    erb :'bookmarks/home'
  end

  get '/bookmarks' do
    @bookmarks = Bookmark.all
    erb :'bookmarks/index'
  end

  get '/bookmarks/new' do
    erb :"bookmarks/new"
  end

  post '/bookmarks' do
    flash[:notice] = 'You must submit a valid URL.' unless Bookmark.create(url: params[:url], title: params[:title])
    redirect('/bookmarks')
  end

  delete '/bookmarks/:id' do
    Bookmark.delete(id: params[:id])
    redirect '/bookmarks'
  end

  get '/bookmarks/:id/edit' do
    @bookmark = Bookmark.find(id: params[:id])
    erb :"bookmarks/edit"
  end

  patch '/bookmarks/:id' do
    Bookmark.update(id: params[:id], title: params[:title], url: params[:url])
    redirect '/bookmarks'
  end

  get '/bookmarks/:id/comments/new' do
    @bookmark_id = params[:id]
    erb :'comments/new'
  end

  post '/bookmarks/:id/comments' do
    connection = PG.connect(dbname: 'bookmark_manager_test')
    connection.exec_params(
      "INSERT INTO comments (text, bookmark_id) VALUES($1, $2);",
      [params[:comment], params[:id]]
      )
    redirect '/bookmarks'
  end

  run! if app_file == $PROGRAM_NAME
end
