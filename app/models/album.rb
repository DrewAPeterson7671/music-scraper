class Album < ApplicationRecord
  validates :artist_id, :album_name, presence: true
  
  belongs_to :artist


  # VAR Albums

  scope :var_albums, -> { where("album = 'Queue'")
    .order('created_at ASC')
    .limit(5) }
  
  scope :var_albums, -> { where("album = 'Previous'")
    .order('created_at ASC')
    .limit(5) }

  scope :var_albums, -> { where("album = 'Billboard'")
    .order('created_at ASC')
    .limit(5) }

  scope :var_albums, -> { where("album = 'VAR'")
    .order('created_at ASC')
    .limit(5) }

  scope :var_albums, -> { where("album = 'MP3Album'")
    .order('created_at ASC')
    .limit(5) }

  scope :var_albums, -> { where("album = 'MP3VAR'")
    .order('created_at ASC')
    .limit(10) }

  scope :var_albums, -> { where("album = 'MP3OST'")
    .order('created_at ASC')
    .limit(5) }

  scope :var_albums, -> { where("album = 'MP3Tribute'")
    .order('created_at ASC')
    .limit(5) }

end
