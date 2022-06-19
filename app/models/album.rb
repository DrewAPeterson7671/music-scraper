class Album < ApplicationRecord
  validates :artist_id, :album_name, presence: true
  
  belongs_to :artist

end
