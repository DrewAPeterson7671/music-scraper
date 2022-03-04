class CreateArtists < ActiveRecord::Migration[6.1]
  def change
    create_table :artists do |t|
      t.string :genre
      t.string :subgenre1
      t.string :subgenre2
      t.string :subgenre3
      t.string :priority
      t.string :pop_list
      t.string :greatest_list
      t.string :current_album
      t.string :current_song

      t.timestamps
    end
  end
end
