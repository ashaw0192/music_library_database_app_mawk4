# file: app.rb
require 'sinatra'
require "sinatra/reloader"
require_relative 'lib/database_connection'
require_relative 'lib/album_repository'
require_relative 'lib/artist_repository'

DatabaseConnection.connect

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    also_reload 'lib/album_repository'
    also_reload 'lib/artist_repository'
  end

  get '/' do
    return erb(:home)
  end

  get '/artists' do
    repo = ArtistRepository.new
    @artists = repo.all
    return erb(:all_artists)
  end

  get '/artists/:id' do
    id = params[:id]
    repo = ArtistRepository.new
    artist = repo.find(id)
    @name = artist.name
    @genre = artist.genre
    return erb(:artist)
  end


  get '/albums' do
    repo = AlbumRepository.new
    @albums = repo.all
    return erb(:all_albums)
  end

  get '/albums/:id' do
    id = params[:id]
    repo_alb = AlbumRepository.new
    repo_art = ArtistRepository.new
    album = repo_alb.find(id)
    @title = album.title
    @release_year = album.release_year
    artist_id = album.artist_id
    artist = repo_art.find(artist_id)
    @name = artist.name
    return erb(:album)
  end

  post '/artists' do
    name = params[:name]
    genre = params[:genre]
    sql = 'INSERT INTO artists (name, genre) VALUES ($1, $2);'
    params = [name, genre]
    DatabaseConnection.exec_params(sql, params)
  end

  post '/albums' do
    title = params[:title]
    release_year = params[:release_year]
    artist_id = params[:artist_id]
    sql = 'INSERT INTO albums (title, release_year, artist_id) VALUES ($1, $2, $3);'
    params = [title, release_year, artist_id]
    DatabaseConnection.exec_params(sql, params)
  end
end