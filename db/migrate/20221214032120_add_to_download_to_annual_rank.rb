class AddToDownloadToAnnualRank < ActiveRecord::Migration[6.1]
  def change
    add_column :annual_ranks, :to_download, :string
  end
end
