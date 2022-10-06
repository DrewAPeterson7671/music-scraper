class AddListenedColumnAndAddListGenreColumn < ActiveRecord::Migration[6.1]
  def change
    add_column :annual_ranks, :rank_listened, :boolean
    add_column :annual_ranks, :rank_genre, :string
  end
end
