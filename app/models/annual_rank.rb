class AnnualRank < ApplicationRecord
  # Custom CSV export queries
  def self.collection_rank_for_export
    AnnualRank.where(type: 'CollectionRank').order(:source, :year, :rank)
  end

  def self.consolidated_annual_rank_for_export
    AnnualRank.where(type: 'ConsolidatedAnnualRank').order(:collection_rank, :year)
  end

  def self.source_for_export(source)
    AnnualRank.where(source: source).order(:year, :rank)
  end

  def self.everything_for_export
    AnnualRank.all.order(:source, :year, :rank)
  end
  # Build a master list of unique ConsolidatedAnnualRank records by rank_artist and rank_track (ILIKE), assign unique_rank, and copy to UniqueConsolidatedRank
  def self.create_unique_consolidated_ranks(start_year = 1980, end_year = Time.now.year)
    # Reset unique_rank for all records
    AnnualRank.update_all(unique_rank: nil)
    seen = []
    unique_rank = 1

    # Step 1: Assign unique_rank to first occurrence of each unique (rank_artist, rank_track) pair in ConsolidatedAnnualRank
    (start_year..end_year).each do |year|
      ConsolidatedAnnualRank.where(year: year).find_each do |rank|
        next if seen.any? { |a, t| a.casecmp(rank.rank_artist.to_s).zero? && t.casecmp(rank.rank_track.to_s).zero? }
        # Find the first matching record in annual_ranks (any type)
        rec = AnnualRank.where('rank_artist ILIKE ? AND rank_track ILIKE ?', rank.rank_artist, rank.rank_track).where(unique_rank: nil).first
        if rec
          rec.update(unique_rank: unique_rank)
          seen << [rec.rank_artist.to_s, rec.rank_track.to_s]
          unique_rank += 1
        end
      end
    end

    # Step 2: Assign unique_rank to first occurrence of each unique (rank_artist, rank_track) pair in CollectionRank not already seen
    CollectionRank.find_each do |col|
      next if seen.any? { |a, t| a.casecmp(col.rank_artist.to_s).zero? && t.casecmp(col.rank_track.to_s).zero? }
      rec = AnnualRank.where('rank_artist ILIKE ? AND rank_track ILIKE ?', col.rank_artist, col.rank_track).where(unique_rank: nil).first
      if rec
        rec.update(unique_rank: unique_rank)
        seen << [rec.rank_artist.to_s, rec.rank_track.to_s]
        unique_rank += 1
      end
    end
  end

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

  def self.rank_artist_the(artist)
    pattern_a = /^((a)\s)/i
    pattern_the = /^((the)\s)/i

    return artist.rank_artist.sub!(pattern_a, "").concat(', A') if artist.rank_artist.match?(pattern_a)
    return artist.rank_artist.sub!(pattern_the, "").concat(', The') if artist.rank_artist.match?(pattern_the)
  end

  def self.rank_artist_the2(artist)
    pattern_a = /^((a)\s)/i
    pattern_the = /^((the)\s)/i

    return artist.sub!(pattern_a, "").concat(', A') if artist.match?(pattern_a)
    return artist.sub!(pattern_the, "").concat(', The') if artist.match?(pattern_the)
  end

  def self.find_artist(rank_artist)
    target_the = rank_artist.rank_artist_the2
    target

    search = target_the.gsub!(/[^0-9A-Za-z]/, '')
    @propose_artist = Artist.where("artists.name ILIKE ?", "%#{search}%")
  end

  def self.change_artist(oldstuff, newstuff)
    @change = AnnualRank.where( rank_artist: oldstuff )
    @change.map do |c|
      c.rank_artist = newstuff
      c.save
    end
  end

  def self.change_track(oldstuff, newstuff)
    @change = AnnualRank.where(rank_track: oldstuff )
    @change.map do |c|
      c.rank_track = newstuff
      c.save
    end
  end

  def self.unsafe_change_track(artist, oldstuff, newstuff)
    @change = AnnualRank.where(rank_artist: artist, rank_track: oldstuff )
    @change.map do |c|
      c.rank_track = newstuff
      c.save
    end
  end

  def self.trim_artists_tracks
    trim = AnnualRank.all
    trim.map do |t|
      t.rank_artist = t.rank_artist&.strip
      t.rank_track = t.rank_track&.strip
      t.save
    end
  end

  def self.titleize_artists_tracks
    trim = AnnualRank.all
    trim.map do |t|
      t.rank_artist = t.rank_artist&.titleize
      t.rank_track = t.rank_track&.titleize
      t.save
    end
  end

  def self.remove_alt_collection
    remove = AnnualRank.where( alt_collection: true )
    remove.map do |r|
      r.alt_collection = false
      r.save
    end
  end

  def self.new_alt_collection
    new_coll = AnnualRank.select("DISTINCT ON(annual_ranks.rank_track, annual_ranks.rank_artist) annual_ranks.*").where(rank_genre: "Alternative")
    new_coll.map do |n|
      n.alt_collection = true
      n.save
    end
  end

  def self.refresh_alt_collection
    remove = AnnualRank.where( alt_collection: true )
    remove.map do |r|
      r.alt_collection = false
      r.save
    end

    new_coll = AnnualRank.select("DISTINCT ON(annual_ranks.rank_track, annual_ranks.rank_artist) annual_ranks.*").where(rank_genre: "Alternative")
    new_coll.map do |n|
      n.alt_collection = true
      n.save
    end
  end

  def self.filtered_for_export(params)
    if params[:alt_collection].present? && params[:source].present? && params[:year].present?
      AnnualRank.where(type: 'CollectionRank').where(source: params[:source]).where(year: params[:year]).order(:rank)
    elsif params[:alt_collection].present? && params[:source].present?
      AnnualRank.where(type: 'CollectionRank').where(source: params[:source]).order(:year, :rank)
    elsif params[:consolidated].present?
      AnnualRank.where(type: 'ConsolidatedAnnualRank').where(year: params[:year]).order(:collection_rank)
    elsif params[:source].present? && params[:year].present?
      AnnualRank.where(source: params[:source]).where(year: params[:year]).where(type: nil).order(:rank)
    elsif params[:source].present?
      AnnualRank.where(source: params[:source]).where(type: nil).order(:year, :rank)
    elsif params[:rank_genre].present? && params[:year].present?
      AnnualRank.where(rank_genre: params[:rank_genre]).where(type: nil).where(year: params[:year]).order(:source, :rank)
    elsif params[:rank_genre].present?
      AnnualRank.where(rank_genre: params[:rank_genre]).where(type: nil).order(:source, :rank)
    elsif params[:unique_consolidated].present?
      AnnualRank.where.not(unique_rank: params[:unique_rank]).order(:unique_rank)
    else
      AnnualRank.where(type: nil).order(:source, :year, :rank)
    end
  end

  # Returns a hash of year => master list of annual ranks for that year, per requirements
  def self.recreate_consolidated_annual_rank(start_year = 1980, end_year = Time.now.year)
    results = {}
    (start_year..end_year).each do |year|

      # Remove old consolidated records for this year
      ConsolidatedAnnualRank.where(year: year).delete_all

      master = AnnualRank.where(year: year, source: 'KROQ').order(:rank).to_a
      # We'll keep a cache of already added records for performance
      added = master.map { |r| [r.rank_artist&.downcase, r.rank_track&.downcase] }

      others = AnnualRank.where(year: year).where(type: nil).where.not(source: ['KROQ', 'Billboard', 'KROQ-1']).order(:rank)

      others.each do |rec|
        # Check for ILIKE match in master list (in DB)
        exists_in_master = AnnualRank.where(year: year, source: 'KROQ').where('rank_artist ILIKE ? AND rank_track ILIKE ?', rec.rank_artist, rec.rank_track).exists?
        # Also check if we've already added this combo from another source
        key = [rec.rank_artist&.downcase, rec.rank_track&.downcase]
        already_added = added.include?(key)
        unless exists_in_master || already_added
          master << rec
          added << key
        end
      end

      master.each_with_index do |rec, idx|
        ConsolidatedAnnualRank.create(
          year: rec.year,
          rank: rec.rank,
          source: rec.source,
          rank_artist: rec.rank_artist,
          rank_track: rec.rank_track,
          rank_album: rec.rank_album,
          rank_genre: rec.rank_genre,
          collection_rank: idx + 1
        )
      end

      # results[year] = master
    end
    # results
  end


  # Scopes

  scope :list_genre, -> { select("rank_genre")
    .distinct
    .order('rank_genre ASC') }
    

  scope :list_source, -> { select("source").where("rank_genre <> 'Alternative All-Time'").distinct
    .order('source ASC') }

  scope :list_year, -> { select("year").distinct
    .order('year ASC') }

  scope :list_collection, -> { select("source").where("type = 'CollectionRank'").distinct }

  scope :lookup_genre, ->(rank_genre) { where("rank_genre = ?", rank_genre) }

  scope :lookup_source, ->(source) { where("source = ?", source) }

  scope :lookup_year, ->(target_year) { where("year = ?", target_year)
    .order('rank') }

  # scope :all_time_alternative, -> { where("rank_genre = 'All-Time Alternative'")
  # .order('rank_artist', 'rank_track') }  
    
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

  scope :annual_rank_download, -> { where( "to_download = 'To Download'" )
    .order('rank')
    }

  scope :annual_rank_download, -> { where( "to_download = 'To Download'" )
    .order('rank')
    }

  scope :annual_rank_download_process, -> { where( "to_download = 'To Process'" )
    .order('rank')
    }

end
