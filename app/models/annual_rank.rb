class AnnualRank < ApplicationRecord

  def self.rank_capture_one_array(year, source, ranks)
    i = -1
    while i < ranks.count - 1 do
      AnnualRank.create(
        year: year, 
        rank: ranks[i += 1], 
        source: source, 
        rank_track: ranks[i += 1], 
        rank_artist: ranks[i += 1], 
        rank_album: ranks[i += 1]
      )
    end
  end

  def self.rank_capture_nested_arrays(year, source, ranks)
    ranks.map do |rank|
      # rank.map do |ran|
      AnnualRank.create(
        year: year,
        rank: rank[0].to_i,
        source: source,
        rank_artist: rank[1],
        rank_track: rank[2],
        rank_album: rank[3]
      )
      # end
    end
  end



  # Need to modify harvest_franks_page_list() to deal with \n\t\t\t the regex is tested good,just not applied correctly.

  # Need to change the class method for rank capture to deal with array inside an array.

end
