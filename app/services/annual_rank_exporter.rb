require 'csv'


class AnnualRankExporter
  def initialize(annual_ranks)
    @annual_ranks = annual_ranks
  end

  def to_csv
    CSV.generate(headers: true) do |csv|
      csv << csv_headers
      @annual_ranks.each do |rank|
        csv << csv_row(rank)
      end
    end
  end

  private

  def csv_headers
    AnnualRank.column_names
  end

  def csv_row(rank)
    AnnualRank.column_names.map { |col| rank.send(col) }
  end
end
