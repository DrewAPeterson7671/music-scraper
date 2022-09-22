class AddMp3ColumnsToAlbums < ActiveRecord::Migration[6.1]
  def change
    add_column :albums, :mp3_only, :boolean
  end
end
