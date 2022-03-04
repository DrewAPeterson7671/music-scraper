class AddAlbumToArtists < ActiveRecord::Migration[6.1]
  def change
    add_column :artists, :album, :string
  end
end
