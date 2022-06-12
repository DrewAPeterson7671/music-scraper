class Album < ApplicationRecord
  validates :album_name, :artist_name, presence: true
  
  belongs_to :artist

end
