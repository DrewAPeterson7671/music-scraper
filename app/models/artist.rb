class Artist < ApplicationRecord
  validates :name, :genre, :priority, presence: true
  validates :name, uniqueness: { message: ': Artist %{value} already exists.' }

  has_many :albums, dependent: :destroy

  paginates_per 50

###### Scopes

### Search

  scope :search, -> (name_parameter) { where("name ILIKE ?", "%#{name_parameter}%")
  .order(:name) }

### Genre Search

  scope :genre_search, -> (genre_parameter) { where("genre ILIKE ?", genre_parameter).order(:name) }

### Paragons

# Alternative

  scope :alternative_paragon_poplist, -> { where("genre = 'Alternative' AND priority = 'Paragon' AND pop_list = 'Active'")
    .order('updated_at ASC')
    .limit(10) }

  scope :alternative_paragon_greatestlist, -> { where("genre = 'Alternative' AND priority = 'Paragon' AND greatest_list = 'Active'")
    .order('updated_at ASC')
    .limit(10) }

  scope :alternative_paragon_album, -> { where("genre = 'Alternative' AND priority = 'Paragon' AND album = 'Active'")
    .order('updated_at ASC')
    .limit(10) }

# Classic Rock

  scope :classicrock_paragon_poplist, -> { where("genre = 'Classic Rock' AND priority = 'Paragon' AND pop_list = 'Active'")
    .order('updated_at ASC')
    .limit(10) }

  scope :classicrock_paragon_greatestlist, -> { where("genre = 'Classic Rock' AND priority = 'Paragon' AND greatest_list = 'Active'")
    .order('updated_at ASC')
    .limit(10) }

  scope :classicrock_paragon_album, -> { where("genre = 'Classic Rock' AND priority = 'Paragon' AND album = 'Active'")
    .order('updated_at ASC')
    .limit(10) }

# 80s Pop

  scope :a80s_paragon_poplist, -> { where("genre = '80s Pop' AND priority = 'Paragon' AND pop_list = 'Active'")
    .order('updated_at ASC')
    .limit(10) }

  scope :a80s_paragon_greatestlist, -> { where("genre = '80s Pop' AND priority = 'Paragon' AND greatest_list = 'Active'")
    .order('updated_at ASC')
    .limit(10) }

  scope :a80s_paragon_album, -> { where("genre = '80s Pop' AND priority = 'Paragon' AND album = 'Active'")
    .order('updated_at ASC')
    .limit(10) }

# Blues

  scope :blues_paragon_poplist, -> { where("genre = 'Blues' AND priority = 'Paragon' AND pop_list = 'Active'")
    .order('updated_at ASC')
    .limit(10) }

  scope :blues_paragon_greatestlist, -> { where("genre = 'Blues' AND priority = 'Paragon' AND greatest_list = 'Active'")
    .order('updated_at ASC')
    .limit(10) }

  scope :blues_paragon_album, -> { where("genre = 'Blues' AND priority = 'Paragon' AND album = 'Active'")
    .order('updated_at ASC')
    .limit(10) }

# Punk

  scope :punk_paragon_poplist, -> { where("genre = 'Punk' AND priority = 'Paragon' AND pop_list = 'Active'")
    .order('updated_at ASC')
    .limit(10) }

  scope :punk_paragon_greatestlist, -> { where("genre = 'Punk' AND priority = 'Paragon' AND greatest_list = 'Active'")
    .order('updated_at ASC')
    .limit(10) }

  scope :punk_paragon_album, -> { where("genre = 'Punk' AND priority = 'Paragon' AND album = 'Active'")
    .order('updated_at ASC')
    .limit(10) }

# Metal

  scope :metal_paragon_poplist, -> { where("genre = 'Metal' AND priority = 'Paragon' AND pop_list = 'Active'")
    .order('updated_at ASC')
    .limit(10) }
  
  scope :metal_paragon_greatestlist, -> { where("genre = 'Metal' AND priority = 'Paragon' AND greatest_list = 'Active'")
    .order('updated_at ASC')
    .limit(10) }

  scope :metal_paragon_current_album, -> { where("genre = 'Metal' AND priority = 'Paragon' AND album = 'Active'")
    .order('updated_at ASC')
    .limit(10) }

# Jam Bands

  scope :jambands_paragon_poplist, -> { where("genre = 'Jam Bands' AND priority = 'Paragon' AND pop_list = 'Active'")
    .order('updated_at ASC')
    .limit(10) }
    
  scope :jambands_paragon_greatestlist, -> { where("genre = 'Jam Bands' AND priority = 'Paragon' AND greatest_list = 'Active'")
    .order('updated_at ASC')
    .limit(10) }

  scope :jambands_paragon_current_album, -> { where("genre = 'Jam Bands' AND priority = 'Paragon' AND album = 'Active'")
    .order('updated_at ASC')
    .limit(10) }

# Rock N Roll

  scope :rocknroll_paragon_poplist, -> { where("genre = 'Rock N Roll' AND priority = 'Paragon' AND pop_list = 'Active'")
    .order('updated_at ASC')
    .limit(10) }
    
  scope :rocknroll_paragon_greatestlist, -> { where("genre = 'Rock N Roll' AND priority = 'Paragon' AND greatest_list = 'Active'")
    .order('updated_at ASC')
    .limit(10) }

  scope :rocknroll_paragon_current_album, -> { where("genre = 'Rock N Roll' AND priority = 'Paragon' AND album = 'Active'")
    .order('updated_at ASC')
    .limit(10) }

# Soul R&B

  scope :soulrb_paragon_poplist, -> { where("genre = 'Soul R&B' AND priority = 'Paragon' AND pop_list = 'Active'")
    .order('updated_at ASC')
    .limit(10) }
    
  scope :soulrb_paragon_greatestlist, -> { where("genre = 'Soul R&B' AND priority = 'Paragon' AND greatest_list = 'Active'")
    .order('updated_at ASC')
    .limit(10) }

  scope :soulrb_paragon_current_album, -> { where("genre = 'Soul R&B' AND priority = 'Paragon' AND album = 'Active'")
    .order('updated_at ASC')
    .limit(10) }

# Disco

  scope :disco_paragon_poplist, -> { where("genre = 'Disco' AND priority = 'Paragon' AND pop_list = 'Active'")
    .order('updated_at ASC')
    .limit(10) }
    
  scope :disco_paragon_greatestlist, -> { where("genre = 'Disco' AND priority = 'Paragon' AND greatest_list = 'Active'")
    .order('updated_at ASC')
    .limit(10) }

  scope :disco_paragon_current_album, -> { where("genre = 'Disco' AND priority = 'Paragon' AND album = 'Active'")
    .order('updated_at ASC')
    .limit(10) }

# Reggae

  scope :reggae_paragon_poplist, -> { where("genre = 'Reggae' AND priority = 'Paragon' AND pop_list = 'Active'")
    .order('updated_at ASC')
    .limit(10) }
    
  scope :reggae_paragon_greatestlist, -> { where("genre = 'Reggae' AND priority = 'Paragon' AND greatest_list = 'Active'")
    .order('updated_at ASC')
    .limit(10) }

  scope :reggae_paragon_current_album, -> { where("genre = 'Reggae' AND priority = 'Paragon' AND album = 'Active'")
    .order('updated_at ASC')
    .limit(10) }

### Focus

# Alternative

  scope :alternative_focus_poplist, -> { where("genre = 'Alternative' AND priority = 'Focus' AND pop_list = 'Active'")
    .order('updated_at ASC')
    .limit(15) }

### Current

# Alternative

  scope :alternative_current_poplist_a_d, -> { where("lower(name) SIMILAR TO '[a-d]%' AND genre = 'Alternative' AND priority = 'Current' AND pop_list = 'Active'")
    .order('updated_at ASC')
    .limit(15)}

  scope :alternative_current_greatestlist_a_d, -> { where("lower(name) SIMILAR TO '[a-d]%' AND genre = 'Alternative' AND priority = 'Current' AND greatest_list = 'Active'")
    .order('updated_at ASC')
    .limit(15)}

  scope :alternative_current_poplist_e_k, -> { where("lower(name) SIMILAR TO '[e-k]%' AND genre = 'Alternative' AND priority = 'Current' AND pop_list = 'Active'")
    .order('updated_at ASC')
    .limit(15)}

  scope :alternative_current_greatestlist_e_k, -> { where("lower(name) SIMILAR TO '[e-k]%' AND genre = 'Alternative' AND priority = 'Current' AND greatest_list = 'Active'")
    .order('updated_at ASC')
    .limit(15)}

  scope :alternative_current_poplist_l_r, -> { where("lower(name) SIMILAR TO '[l-r]%' AND genre = 'Alternative' AND priority = 'Current' AND pop_list = 'Active'")
    .order('updated_at ASC')
    .limit(15)}

  scope :alternative_current_greatestlist_l_r, -> { where("lower(name) SIMILAR TO '[l-r]%' AND genre = 'Alternative' AND priority = 'Current' AND greatest_list = 'Active'")
    .order('updated_at ASC')
    .limit(15)}

  scope :alternative_current_poplist_s_z, -> { where("lower(name) SIMILAR TO '[s-z, 0-9]%' AND genre = 'Alternative' AND priority = 'Current' AND pop_list = 'Active'")
    .order('updated_at ASC')
    .limit(15)}

  scope :alternative_current_greatestlist_s_z, -> { where("lower(name) SIMILAR TO '[s-z, 0-9]%' AND genre = 'Alternative' AND priority = 'Current' AND greatest_list = 'Active'")
    .order('updated_at ASC')
    .limit(15)}

  scope :alternative_current_album, -> { where("genre = 'Alternative' AND priority = 'Current' AND album = 'Active'")
    .order('updated_at ASC')
    .limit(10) }

# Classic Rock

  scope :classicrock_current_poplist, -> { where("genre = 'Classic Rock' AND priority = 'Current' AND pop_list = 'Active'")
    .order('updated_at ASC')
    .limit(10) }

  scope :classicrock_current_greatestlist, -> { where("genre = 'Classic Rock' AND priority = 'Current' AND greatest_list = 'Active'")
    .order('updated_at ASC')
    .limit(10) }

  scope :classicrock_current_album, -> { where("genre = 'Classic Rock' AND priority = 'Current' AND album = 'Active'")
    .order('updated_at ASC')
    .limit(10) }

# 80s Pop

  scope :a80s_current_poplist, -> { where("genre = '80s Pop' AND priority = 'Current' AND pop_list = 'Active'")
    .order('updated_at ASC')
    .limit(10) }

  scope :a80s_current_greatestlist, -> { where("genre = '80s Pop' AND priority = 'Current' AND greatest_list = 'Active'")
    .order('updated_at ASC')
    .limit(10) }

  scope :a80s_current_album, -> { where("genre = '80s Pop' AND priority = 'Current' AND album = 'Active'")
    .order('updated_at ASC')
    .limit(10) }

# Blues

  scope :blues_current_poplist, -> { where("genre = 'Blues' AND priority = 'Current' AND pop_list = 'Active'")
    .order('updated_at ASC')
    .limit(10) }

  scope :blues_current_greatestlist, -> { where("genre = 'Blues' AND priority = 'Current' AND greatest_list = 'Active'")
    .order('updated_at ASC')
    .limit(10) }

  scope :blues_current_album, -> { where("genre = 'Blues' AND priority = 'Current' AND album = 'Active'")
    .order('updated_at ASC')
    .limit(10) }

# Punk

scope :punk_current_poplist, -> { where("genre = 'Punk' AND priority = 'Current' AND pop_list = 'Active'")
  .order('updated_at ASC')
  .limit(10) }

scope :punk_current_greatestlist, -> { where("genre = 'Punk' AND priority = 'Current' AND greatest_list = 'Active'")
  .order('updated_at ASC')
  .limit(10) }

scope :punk_current_album, -> { where("genre = 'Punk' AND priority = 'Current' AND album = 'Active'")
  .order('updated_at ASC')
  .limit(10) }

# Metal

scope :metal_current_poplist, -> { where("genre = 'Metal' AND priority = 'Current' AND pop_list = 'Active'")
  .order('updated_at ASC')
  .limit(10) }

scope :metal_current_greatestlist, -> { where("genre = 'Metal' AND priority = 'Current' AND greatest_list = 'Active'")
  .order('updated_at ASC')
  .limit(10) }

scope :metal_current_current_album, -> { where("genre = 'Metal' AND priority = 'Current' AND album = 'Active'")
  .order('updated_at ASC')
  .limit(10) }

# Jam Bands

scope :jambands_current_poplist, -> { where("genre = 'Jam Bands' AND priority = 'Current' AND pop_list = 'Active'")
  .order('updated_at ASC')
  .limit(10) }
  
scope :jambands_current_greatestlist, -> { where("genre = 'Jam Bands' AND priority = 'Current' AND greatest_list = 'Active'")
  .order('updated_at ASC')
  .limit(10) }

scope :jambands_current_current_album, -> { where("genre = 'Jam Bands' AND priority = 'Current' AND album = 'Active'")
  .order('updated_at ASC')
  .limit(10) }

# Rock N Roll

scope :rocknroll_current_poplist, -> { where("genre = 'Rock N Roll' AND priority = 'Current' AND pop_list = 'Active'")
  .order('updated_at ASC')
  .limit(10) }
  
scope :rocknroll_current_greatestlist, -> { where("genre = 'Rock N Roll' AND priority = 'Current' AND greatest_list = 'Active'")
  .order('updated_at ASC')
  .limit(10) }

scope :rocknroll_current_current_album, -> { where("genre = 'Rock N Roll' AND priority = 'Current' AND album = 'Active'")
  .order('updated_at ASC')
  .limit(10) }

# Soul R&B

scope :soulrb_current_poplist, -> { where("genre = 'Soul R&B' AND priority = 'Current' AND pop_list = 'Active'")
  .order('updated_at ASC')
  .limit(10) }
  
scope :soulrb_current_greatestlist, -> { where("genre = 'Soul R&B' AND priority = 'Current' AND greatest_list = 'Active'")
  .order('updated_at ASC')
  .limit(10) }

scope :soulrb_current_current_album, -> { where("genre = 'Soul R&B' AND priority = 'Current' AND album = 'Active'")
  .order('updated_at ASC')
  .limit(10) }

# Disco

scope :disco_current_poplist, -> { where("genre = 'Disco' AND priority = 'Current' AND pop_list = 'Active'")
  .order('updated_at ASC')
  .limit(10) }
  
scope :disco_current_greatestlist, -> { where("genre = 'Disco' AND priority = 'Current' AND greatest_list = 'Active'")
  .order('updated_at ASC')
  .limit(10) }

scope :disco_current_current_album, -> { where("genre = 'Disco' AND priority = 'Current' AND album = 'Active'")
  .order('updated_at ASC')
  .limit(10) }

# Reggae

scope :reggae_current_poplist, -> { where("genre = 'Reggae' AND priority = 'Current' AND pop_list = 'Active'")
  .order('updated_at ASC')
  .limit(10) }
  
scope :reggae_current_greatestlist, -> { where("genre = 'Reggae' AND priority = 'Current' AND greatest_list = 'Active'")
  .order('updated_at ASC')
  .limit(10) }

scope :reggae_current_current_album, -> { where("genre = 'Reggae' AND priority = 'Current' AND album = 'Active'")
  .order('updated_at ASC')
  .limit(10) }



end
