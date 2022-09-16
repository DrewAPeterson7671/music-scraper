class Album < ApplicationRecord
  validates :artist_id, :album_name, :year, presence: true
  
  belongs_to :artist


  # VAR Album Scopes

  scope :var_albums, -> { where("album_queue = 'VAR Queue'")
    .order('created_at ASC')
    .limit(5) }

  scope :var_mp3_albums, -> { where("album_queue = 'MP3VAR'")
    .order('created_at ASC')
    .limit(5) }

  scope :ost_albums, -> { where("album_queue = 'OST Queue'")
    .order('created_at ASC')
    .limit(5) }

  scope :ost_mp3_albums, -> { where("album_queue = 'MP3OST'")
    .order('created_at ASC')
    .limit(5) }

  scope :tribute_albums, -> { where("album_queue = 'Tribute Queue'")
    .order('created_at ASC')
    .limit(5) }

  scope :tribute_mp3_albums, -> { where("album_queue = 'MP3Tribute'")
    .order('created_at ASC')
    .limit(5) }
    
  scope :previous_albums, -> { where("album_queue = 'Previous' AND download_status = '""'")
    .order('created_at ASC')
    .limit(5) }

  scope :billboard_albums, -> { where("album_queue = 'Billboard' AND download_status = '""'")
    .order('created_at ASC')
    .limit(5) }

  scope :mp3_albums, -> { where("album_queue = 'MP3Album'")
    .order('created_at ASC')
    .limit(5) }

end
