class Artist < ApplicationRecord
  validates :name, :genre, :priority, presence: true
  validates :name, uniqueness: { message: ': Artist %{value} already exists.' }


  scope :alternative_paragon_poplist, -> { where("genre = 'Alternative' AND priority = 'Paragon' AND pop_list = 'Active'")
    .order('updated_at ASC')
    .limit(10) }

  scope :alternative_paragon_greatestlist, -> { where("genre = 'Alternative' AND priority = 'Paragon' AND greatest_list = 'Active'")
    .order('updated_at ASC')
    .limit(10) }

  scope :alternative_paragon_album, -> { where("genre = 'Alternative' AND priority = 'Paragon' AND album = 'Active'")
    .order('updated_at ASC')
    .limit(10) }

# Complete Lists

  scope :alpha_alternative_paragon_poplist, -> { where("genre = 'Alternative' AND priority = 'Paragon' AND pop_list = 'Active'")
    .order('name ASC') }

    scope :alpha_alternative_paragon_greatestlist, -> { where("genre = 'Alternative' AND priority = 'Paragon' AND greatest_list = 'Active'")
      .order('name ASC') }
  
    scope :alpha_alternative_paragon_album, -> { where("genre = 'Alternative' AND priority = 'Paragon' AND album = 'Active'")
      .order('name ASC') }

end



# Problem with 
