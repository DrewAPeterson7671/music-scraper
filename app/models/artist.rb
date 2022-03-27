class Artist < ApplicationRecord
  validates :name, :genre, :priority, presence: true
  validates :name, uniqueness: { message: ': Artist %{value} already exists.' }

  paginates_per 50

  scope :search, -> (name_parameter) { where("name LIKE ?", "%#{name_parameter}%") }

  scope :alternative_paragon_poplist, -> { where("genre = 'Alternative' AND priority = 'Paragon' AND pop_list = 'Active'")
    .order('updated_at ASC')
    .limit(10) }

  scope :alternative_paragon_greatestlist, -> { where("genre = 'Alternative' AND priority = 'Paragon' AND greatest_list = 'Active'")
    .order('updated_at ASC')
    .limit(10) }

  scope :alternative_paragon_album, -> { where("genre = 'Alternative' AND priority = 'Paragon' AND album = 'Active'")
    .order('updated_at ASC')
    .limit(10) }
  
  scope :alternative_focus_poplist, -> { where("genre = 'Alternative' AND priority = 'Focus' AND pop_list = 'Active'")
    .order('updated_at ASC')
    .limit(15) }


  scope :classicrock_paragon_poplist, -> { where("genre = 'Classic Rock' AND priority = 'Paragon' AND pop_list = 'Active'")
    .order('updated_at ASC')
    .limit(10) }

  scope :classicrock_paragon_greatestlist, -> { where("genre = 'Classic Rock' AND priority = 'Paragon' AND greatest_list = 'Active'")
    .order('updated_at ASC')
    .limit(10) }

  scope :classicrock_paragon_album, -> { where("genre = 'Classic Rock' AND priority = 'Paragon' AND album = 'Active'")
    .order('updated_at ASC')
    .limit(10) }

  scope :classicrock_current_poplist, -> { where("genre = 'Classic Rock' AND priority = 'Current' AND pop_list = 'Active'")
    .order('updated_at ASC')
    .limit(10) }

  scope :classicrock_current_greatestlist, -> { where("genre = 'Classic Rock' AND priority = 'Current' AND greatest_list = 'Active'")
    .order('updated_at ASC')
    .limit(10) }

  scope :classicrock_current_album, -> { where("genre = 'Classic Rock' AND priority = 'Current' AND album = 'Active'")
    .order('updated_at ASC')
    .limit(10) }

  scope :blues_current_poplist, -> { where("genre = 'Blues' AND priority = 'Current' AND pop_list = 'Active'")
    .order('updated_at ASC')
    .limit(10) }

  scope :blues_current_greatestlist, -> { where("genre = 'Blues' AND priority = 'Current' AND greatest_list = 'Active'")
    .order('updated_at ASC')
    .limit(10) }

  scope :blues_current_album, -> { where("genre = 'Blues' AND priority = 'Current' AND album = 'Active'")
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
