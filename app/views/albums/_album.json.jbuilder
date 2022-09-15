json.extract! album, :id, :album_name, :album_queue, :artist_id, :year, :album_genre, :album_priority, :album_type, :album_complete, :album_download, :current_album_song, :album_version, :download_verified, :download_status, :rating, :normalized_tagged, :compiliation, :album_sub_genre1, :album_sub_genre2, :created_at, :updated_at
json.url album_url(album, format: :json)
