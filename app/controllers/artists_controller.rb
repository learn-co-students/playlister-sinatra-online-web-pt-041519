class ApplicationController < Sinatra::Base
  
    get '/artists' do
        @artists = Artist.all
        erb :'/artists/index'
    end

    get '/artists/new' do
    end

    get '/artists/:slug' do
        @artist_instance = Artist.find_by_slug(params[:slug])
        @artist_id = @artist_instance.id
        @artist_songs = Song.find_by(artist_id: @artist_id)
        @artist_song_name = @artist_songs.name
        @artist_song_id = @artist_songs.id
        @artist_song_name_slug = @artist_songs.slug
        @song_genre_instance = SongGenre.find_by(song_id: @artist_song_id)
        @genre_id = @song_genre_instance.genre_id
        @song_genre = Genre.find_by(id: @genre_id)
        @song_genre_slug = @song_genre.slug
        @song_genre_name = @song_genre.name
        erb :'/artists/show'
    end


  end