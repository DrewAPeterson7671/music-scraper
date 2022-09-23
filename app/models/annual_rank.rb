class AnnualRank < ApplicationRecord

  def self.rank_capture(year, source, ranks)
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

  # Need to modify harvest_franks_page_list() to deal with \n\t\t\t

  # Need to change the class method for rank capture to deal with array inside an array.

end
