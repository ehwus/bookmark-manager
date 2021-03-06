require 'sinatra/base'
require './database_connection_setup'
require './lib/bookmark'
require './lib/comment'
require 'uri'
require 'sinatra/flash'
require './lib/tag'

class BookmarkManager < Sinatra::Base
  enable :sessions, :method_override
  register Sinatra::Flash

  get '/' do
    redirect('/bookmarks')
  end

  get '/bookmarks' do
    @bookmarks = Bookmark.all
    erb :'bookmarks/index'
  end

  get '/bookmarks/new' do
    erb :'bookmarks/new'
  end

  post '/bookmarks' do
    flash[:notice] = 'Please enter a valid URL.' unless Bookmark.create(url: params[:url], title: params[:title])
    redirect('/bookmarks')
  end

  delete '/bookmarks/:id' do
    Bookmark.delete(id: params[:id])
    redirect('/bookmarks')
  end

  patch '/bookmarks/:id' do
    Bookmark.update(id: params[:id], title: params[:title], url: params[:url])
    redirect('/bookmarks')
  end

  get '/bookmarks/:id/edit' do
    @bookmark = Bookmark.find(id: params[:id])
    erb :'bookmarks/edit'
  end

  get '/bookmarks/:id/comments/new' do
    @bookmark_id = params[:id]
    erb :'comments/new'
  end

  post '/bookmarks/:id/comments' do
    Comment.create(text: params[:comment], bookmark_id: params[:id].to_i)
    redirect('/bookmarks')
  end

  get '/bookmarks/:id/tags/new' do
    erb :'tags/new'
  end

  post '/bookmarks/:id/tags/' do
    Tag.add_tag(tag_id: params[:id], value: params[:tag])
    redirect('/bookmarks')
  end

  run! if app_file == $0
end
