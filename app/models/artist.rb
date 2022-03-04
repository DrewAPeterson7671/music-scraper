class Artist < ApplicationRecord
  validates :name, :genre, :priority, presence: true,
  validates :name, uniqueness: { message: ': Artist %{value} already exists.' }

end

# NEED TO ELIMINATE BLANKS
