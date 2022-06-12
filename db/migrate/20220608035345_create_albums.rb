class CreateAlbums < ActiveRecord::Migration[6.1]
  def change
    create_table :albums do |t|
      t.string :album_name
      t.integer :artist_id
      t.integer :year
      t.string :album_genre
      t.string :album_priority
      t.string :album_type
      t.string :album_complete
      t.string :album_download
      t.string :current_album_song
      t.string :album_version
      t.string :download_verified
      t.string :download_status
      t.integer :rating
      t.boolean :normalized_tagged
      t.boolean :compiliation
      t.string :album_sub_genre1
      t.string :album_sub_genre2

      t.timestamps
    end
  end
end
