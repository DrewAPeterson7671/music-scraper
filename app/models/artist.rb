class Artist < ApplicationRecord
  validates :name, :genre, :priority, presence: true
  validates :name, uniqueness: { message: ': Artist %{value} already exists.' }


  scope :alternative_paragon_poplist, -> { where("genre = 'Alternative' AND priority = 'Paragon' AND pop_list = 'Active'")
    .order('updated_at ASC')
    .limit(10) }

end



# Problem with 
