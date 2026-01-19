class AddUniqueRankToAnnualRank < ActiveRecord::Migration[6.0]
  def change
    add_column :annual_ranks, :unique_rank, :integer
  end
end
