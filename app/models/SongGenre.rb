class SongGenre < ActiveRecord::Base
    belongs_to :song
    belongs_to :genre

    def self.find_by_genre_id(id)
        SongGenre.all.find{|item| item.genre_id == id}
    end
end
