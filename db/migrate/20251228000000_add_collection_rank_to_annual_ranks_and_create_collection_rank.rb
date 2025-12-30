class AddCollectionRankToAnnualRanksAndCreateCollectionRank < ActiveRecord::Migration[6.0]
  def change
    add_column :annual_ranks, :collection_rank, :integer
    add_column :annual_ranks, :type, :string unless column_exists?(:annual_ranks, :type)
  end
end
