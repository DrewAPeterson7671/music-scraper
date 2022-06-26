class Album < ApplicationRecord
  validates :artist_id, :album_name, presence: true
  
  belongs_to :artist

  # Album Scope

# def self.studio_albums(artist)
#   @albums_studio = Album.where("artist_id = artist.id AND album_type = 'Studio'")
# end

end
