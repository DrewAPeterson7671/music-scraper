class AddAlternativeGreatestCollectionToAnnualRank < ActiveRecord::Migration[6.1]
  def change
    add_column :annual_ranks, :alt_collection, :boolean
  end
end
