class AddArtistToAlbums < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :albums, :artists
  end
end
