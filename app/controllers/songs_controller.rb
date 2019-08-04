class ApplicationController < Sinatra::Base
  
    get '/songs' do
        @songs = Song.all
        erb :'/songs/index'
    end

    get '/songs/new' do
        @genres = Genre.all 
        @artists = Artist.all
        erb :'/songs/new'
    end

    post '/songs/new' do
        if params["Artist Name"].empty?
            @artist = Artist.find_by(id: params["artists"])
        else
            @artist = Artist.find_or_create_by(name: params["Artist Name"])
        end
        @song = Song.create(name: params[:Name])
        @slug = @song.slug
        @artist.songs << @song
        @genre_instance = Genre.find_by(id: params[:genres])
        @song_genre_instance = SongGenre.create(song_id: @song.id, genre_id: @genre_instance.id)
        @song.save
        redirect "/songs/#{@slug}"
    end
   
    get '/songs/:slug' do
        @song_instance = Song.find_by_slug(params[:slug])
        @song_name = @song_instance.name
        @song_artist_name = @song_instance.artist.name
        @song_artist_slug = @song_instance.artist.slug
        @song_id = @song_instance.id
        @song_genre_object = SongGenre.find_by(song_id: @song_id)
        @genre_id = @song_genre_object.genre_id
        @song_genre_object = Genre.find_by(id: @genre_id)
        @song_genre_name = @song_genre_object.name
        @song_genre_slug = @song_genre_object.slug
        @success = "Successfully created song."
        erb :'/songs/show'
    end
    
    get '/songs/:slug/edit' do
        @song = Song.find_by_slug(params[:slug])
        @artists = Artist.all
        @genres = Genre.all
        @song_genre = SongGenre.find_by(song_id: @song.id)
        erb :'/songs/edit'
    end

    patch '/songs/:slug' do
        @updated_song = Song.find_by_slug(params[:slug])
        @slug = params[:slug]
        if params["Artist Name"].empty?
            @updated_artist = Artist.find_by(id: params["artists"])
        else
            @updated_artist = Artist.find_or_create_by(name: params["Artist Name"])
        end

        if params["Genre Name"].empty?
            @updated_genre = Genre.find_by(id: params["genres"])
        else
            @updated_genre = Genre.find_or_create_by(name: params["Genre Name"])
        end
        
        @updated_song.save
        @updated_artist.save
        @updated_genre.save
        @successful_update = "Successfully updated song."
        @updated_song_name = @updated_song.name
        @updated_artist = @updated_artist.name
        @updated_genre_name = @updated_genre.name
        erb :'/songs/show'
    end


end