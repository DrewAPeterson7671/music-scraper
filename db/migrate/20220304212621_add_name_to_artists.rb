class AddNameToArtists < ActiveRecord::Migration[6.1]
  def change
    add_column :artists, :name, :string
  end
end
