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
        rank_album: ranks[i += 1],
        rank_listened: false
      )
    end
  end

  def self.rank_capture_nested_arrays(year, source, genre, ranks)
    ranks.map do |rank|
      # rank.map do |ran|
      AnnualRank.create(
        year: year,
        rank: rank[0].to_i,
        source: source,
        rank_artist: rank[1],
        rank_track: rank[2],
        rank_album: rank[3],
        rank_listened: false,
        rank_genre: genre
      )
      # end
    end
  end

  # Scopes

  scope :list_genre, -> { select("rank_genre")
    .distinct
    .order('rank_genre ASC') }
    

  scope :list_source, -> { select("source").where("rank_genre <> 'Alternative All-Time'").distinct
    .order('source ASC') }

  scope :list_year, -> { select("year").distinct
    .order('year ASC') }

  scope :list_rank_genre, -> { select("source").where(rank_genre: 'Alternative All-Time')
    .distinct
    .order('rank_genre ASC') }

  scope :lookup_genre, ->(rank_genre) { where("rank_genre = ?", rank_genre) }

  scope :lookup_source, ->(source) { where("source = ?", source) }

  scope :lookup_year, ->(target_year) { where("year = ?", target_year)
    .order('rank') }
  
  scope :billboard_1955, -> { where( "source = 'Billboard' AND year = 1955 AND rank_listened = false" )
    .order('rank')
    .limit(5) }
  
  scope :billboard_1960, -> { where( "source = 'Billboard' AND year = 1960 AND rank_listened = false" )
    .order('rank')
    .limit(10) }

  scope :billboard_1965, -> { where( "source = 'Billboard' AND year = 1965 AND rank_listened = false" )
    .order('rank')
    .limit(10) }

  scope :billboard_1970, -> { where( "source = 'Billboard' AND year = 1970 AND rank_listened = false" )
    .order('rank')
    .limit(10) }

  scope :billboard_1980, -> { where( "source = 'Billboard' AND year = 1980 AND rank_listened = false" )
    .order('rank')
    .limit(10) }

  scope :billboard_1990, -> { where( "source = 'Billboard' AND year = 1990 AND rank_listened = false" )
    .order('rank')
    .limit(10) }

  scope :billboard_2000, -> { where( "source = 'Billboard' AND year = 2000 AND rank_listened = false" )
    .order('rank')
    .limit(10) }

  scope :billboard_2010, -> { where( "source = 'Billboard' AND year = 2010 AND rank_listened = false" )
    .order('rank')
    .limit(10) }

  scope :billboard_2020, -> { where( "source = 'Billboard' AND year = 2020 AND rank_listened = false" )
    .order('rank')
    .limit(10) }

  scope :kroq_1980, -> { where( "source = 'KROQ' AND year = 1980 AND rank_listened = false" )
    .order('rank')
    .limit(10) }  

  scope :kroq_1985, -> { where( "source = 'KROQ' AND year = 1985 AND rank_listened = false" )
    .order('rank')
    .limit(10) }

  scope :kroq_1990, -> { where( "source = 'KROQ' AND year = 1990 AND rank_listened = false" )
    .order('rank')
    .limit(10) }  

  scope :kroq_1995, -> { where( "source = 'KROQ' AND year = 1995 AND rank_listened = false" )
    .order('rank')
    .limit(10) }

  scope :kroq_2000, -> { where( "source = 'KROQ' AND year = 2000 AND rank_listened = false" )
    .order('rank')
    .limit(10) }  

  scope :kroq_2005, -> { where( "source = 'KROQ' AND year = 2005 AND rank_listened = false" )
    .order('rank')
    .limit(10) }

  scope :kroq_2010, -> { where( "source = 'KROQ' AND year = 2010 AND rank_listened = false" )
    .order('rank')
    .limit(10) }  

  scope :kroq_2015, -> { where( "source = 'KROQ' AND year = 2015 AND rank_listened = false" )
    .order('rank')
    .limit(10) }

end
