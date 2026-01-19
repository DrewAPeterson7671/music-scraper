namespace :annual_rank do
  desc "Export annual ranks to CSV using controller-like filters. Pass filter params as ENV variables."
  task :export => :environment do
    # Example usage:
    #   SOURCE=KROQ YEAR=2025 ALT_COLLECTION=true rake annual_rank:export
    #   CONSOLIDATED=true YEAR=2025 rake annual_rank:export
    #   RANK_GENRE=Rock rake annual_rank:export
    #   UNIQUE_CONSOLIDATED=true UNIQUE_RANK=42 rake annual_rank:export
    #   rake annual_rank:export
    # EXPORT_TYPE=collection_rank rake annual_rank:export
    # EXPORT_TYPE=consolidated_annual_rank rake annual_rank:export
    # EXPORT_TYPE=source SOURCE=YourSourceName rake annual_rank:export
    # EXPORT_TYPE=everything rake annual_rank:export

    # Choose export type by ENV['EXPORT_TYPE']
    # Options: collection_rank, consolidated_annual_rank, source, everything, or default (filtered_for_export)
    export_type = (ENV['EXPORT_TYPE'] || 'filtered').downcase
    timestamp = Time.now.strftime('%Y-%m-%d')
    params_str = [
      ENV['SOURCE'] && "source-#{ENV['SOURCE']}",
      ENV['YEAR'] && "year-#{ENV['YEAR']}",
      ENV['RANK_GENRE'] && "genre-#{ENV['RANK_GENRE']}"
    ].compact.join('_')
    filename = [
      'annual_ranks',
      export_type,
      params_str,
      timestamp
    ].reject(&:empty?).join('_') + '.csv'
    output = ENV['OUTPUT'] || File.join('tmp', filename)

    annual_ranks = case export_type
    when 'collection_rank'
      AnnualRank.collection_rank_for_export
    when 'consolidated_annual_rank'
      AnnualRank.consolidated_annual_rank_for_export
    when 'source'
      source = ENV['SOURCE']
      if source.blank?
        puts 'Please provide SOURCE=your_source for EXPORT_TYPE=source'
        exit 1
      end
      AnnualRank.source_for_export(source)
    when 'everything'
      AnnualRank.everything_for_export
    else
      params = {
        alt_collection: ENV['ALT_COLLECTION'],
        source: ENV['SOURCE'],
        year: ENV['YEAR'],
        consolidated: ENV['CONSOLIDATED'],
        rank_genre: ENV['RANK_GENRE'],
        unique_consolidated: ENV['UNIQUE_CONSOLIDATED'],
        unique_rank: ENV['UNIQUE_RANK']
      }.delete_if { |_, v| v.nil? }
      AnnualRank.filtered_for_export(params)
    end

    csv_data = AnnualRankExporter.new(annual_ranks).to_csv
    File.write(output, csv_data)
    puts "Exported #{annual_ranks.count} annual ranks to #{output}"
  end
end
