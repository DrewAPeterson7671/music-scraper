class AddListenColumnToAlbums < ActiveRecord::Migration[6.1]
  def change
    add_column :albums, :listen, :string
  end
end
