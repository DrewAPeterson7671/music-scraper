class AddArtistFields < ActiveRecord::Migration[6.1]
  def change
    add_column :artists, :to_download, :string
    add_column :artists, :download_type, :string
    add_column :artists, :download_date, :date
    add_column :artists, :download_status, :string
    add_column :artists, :wiki_page, :string
    add_column :artists, :discogs_page, :string
    add_column :artists, :current_download, :string
    add_column :artists, :dl_listen_album, :string
    add_column :artists, :dl_listen_song, :string
  end
end
