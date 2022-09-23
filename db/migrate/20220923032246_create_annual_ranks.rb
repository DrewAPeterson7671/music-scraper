class CreateAnnualRanks < ActiveRecord::Migration[6.1]
  def change
    create_table :annual_ranks do |t|
      t.integer :year
      t.integer :rank
      t.string :source
      t.string :rank_artist
      t.string :rank_track
      t.string :rank_album

      t.timestamps
    end
  end
end
