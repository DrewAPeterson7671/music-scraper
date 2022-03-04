json.extract! artist, :id, :genre, :subgenre1, :subgenre2, :subgenre3, :priority, :pop_list, :greatest_list, :current_album, :current_song, :created_at, :updated_at
json.url artist_url(artist, format: :json)
