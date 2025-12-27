class Album < ApplicationRecord
  validates :artist_id, :album_name, :year, presence: true
  
  belongs_to :artist


  # VAR Album Scopes

  scope :var_albums, -> { where("album_queue = 'VAR Queue' AND mp3_only = false AND listen = 'Now'")
    .order('created_at ASC')
    .limit(5) }

  scope :var_mp3_albums, -> { where("album_queue = 'VAR Queue' AND mp3_only = true AND listen = 'Now'")
    .order('created_at ASC')
    .limit(12) }

  scope :ost_albums, -> { where("album_queue = 'OST Queue' AND mp3_only = false AND listen = 'Now'")
    .order('created_at ASC')
    .limit(10) }

  scope :ost_mp3_albums, -> { where("album_queue = 'OST Queue' AND mp3_only = true AND listen = 'Now'")
    .order('created_at ASC')
    .limit(10) }

  scope :tribute_albums, -> { where("album_queue = 'Tribute Queue' AND mp3_only = false AND listen = 'Now'")
    .order('created_at ASC')
    .limit(12) }

  scope :tribute_mp3_albums, -> { where("album_queue = 'Tribute Queue' AND mp3_only = true AND listen = 'Now'")
    .order('created_at ASC')
    .limit(10) }
    
  scope :previous_albums, -> { where("album_queue = 'Previous' AND download_status = '""' AND listen = 'Now'")
    .order('created_at ASC')
    .limit(5) }

  scope :billboard_albums, -> { where("album_queue = 'Billboard' AND download_status = '""' AND listen = 'Now'")
    .order('created_at ASC')
    .limit(5) }

  scope :top_independent_albums, -> { where("album_queue = 'Top Independent' AND download_status = '""' AND listen = 'Now'")
      .order('created_at ASC')
      .limit(5) }

  scope :top_metal_albums, -> { where("album_queue = 'Metal' AND download_status = '""' AND listen = 'Now'")
    .order('created_at ASC')
    .limit(5) }

  scope :top_punk_albums, -> { where("album_queue = 'Punk' AND download_status = '""' AND listen = 'Now'")
    .order('created_at ASC')
    .limit(5) }
    
  scope :top_reggae_albums, -> { where("album_queue = 'Reggae' AND download_status = '""' AND listen = 'Now'")
    .order('created_at ASC')
    .limit(5) }

  scope :mp3_albums, -> {
    select('DISTINCT ON (artist_id) *')
      .where("album_queue = 'MP3Album' AND listen = 'Now'")
      .order('artist_id, created_at ASC')
      .limit(10)
  }

    #NEED to make a scope for Bonus Only MP3 albums

end
