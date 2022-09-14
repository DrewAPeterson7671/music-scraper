class AddAlbumQueueToAlbumsTable < ActiveRecord::Migration[6.1]
  def change
    add_column :albums, :album_queue, :string
  end
end
