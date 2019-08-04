class ApplicationController < Sinatra::Base
  
    get '/genres' do
        @genres = Genre.all
        erb :'/genres/index'
    end

    get '/genres/new' do
    end

    get '/genres/:slug' do
        @genre_instance = Genre.find_by_slug(params[:slug])
        @genre_id = @genre_instance.id
        @song_genre_instance = SongGenre.find_by_genre_id(@genre_id)
        @song_id = @song_genre_instance.song_id
        @song = Song.all.find{|song| song.id == @song_id}
        @song_name = @song.name
        @song_slug = @song.slug
        @artist_id = @song.artist_id
        @song_artist = Artist.all.find{|artist| artist.id == @artist_id}
        @song_artist_name = @song_artist.name
        @song_artist_slug = @song_artist.slug
        erb :'/genres/show'
    end
  end