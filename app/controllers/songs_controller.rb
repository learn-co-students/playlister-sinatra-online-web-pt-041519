require 'rack-flash'
class SongsController < ApplicationController
  use Rack::Flash

  # All songs
  get '/songs' do
    @songs = Song.all
    erb :'songs/index'
  end

  # # Display new song form
  get '/songs/new' do
    @songs = Song.all 
    erb :'/songs/new'
  end

  # Create new song from post
  post '/songs' do 
    @song = Song.create(params[:song])
    @song.artist = Artist.find_or_create_by(name: params[:artist_name])
    @song.save
    
    flash[:message] = "Successfully created song."
    redirect "/songs/#{@song.slug}"
  end

  get '/songs/:slug/edit' do 
    @song = Song.find_by_slug(params[:slug])
    erb :'/songs/edit'
  end

  get '/songs/:slug' do 
    @song = Song.find_by_slug(params[:slug])
    erb :'/songs/show'
  end

  patch '/songs/:slug' do    
    # Set empty array if no genre checkboxes
    if !params[:song].keys.include?("genre_ids")
      params[:song]["genre_ids"] = []
    end

    # Find song and update
    @song = Song.find_by_slug(params[:slug])
    @song.update(params[:song])

    # If artist param, find or create new and save song
    if !params[:artist_name].empty?
      @song.artist = Artist.find_or_create_by(name: params[:artist_name])
    end
    @song.save
    
    # Update user and redirect
    flash[:message] = "Successfully updated song."
    redirect "/songs/#{@song.slug}"
  end
end