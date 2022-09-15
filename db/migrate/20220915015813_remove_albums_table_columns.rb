class RemoveAlbumsTableColumns < ActiveRecord::Migration[6.1]
  def change
    remove_column :albums, :album_genre, :string
    remove_column :albums, :album_priority, :string
    remove_column :albums, :album_complete, :string
    remove_column :albums, :download_verified, :string
    remove_column :albums, :normalized_tagged, :boolean
    remove_column :albums, :compiliation, :boolean
    remove_column :albums, :album_sub_genre1, :string
    remove_column :albums, :album_sub_genre2, :string
  end
end
