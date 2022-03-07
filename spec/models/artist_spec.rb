require 'rails_helper'

RSpec.describe Artist, type: :model do

  before (:all) do
   @artist = Artist.create(name: "The Cure", genre: "Alternative")
  end

  it 'checks that an artist can be created' do
    expect(@artist).to be_valid
  end

  it 'checks that an artist can be read' do
    expect(Artist.find_by_name("The Cure"))
  end

  it 'checks that an artist can be updated' do
    @artist.update(:name => "R.E.M.")
    expect(Artist.find_by_name("R.E.M.")).to eq(@artist)
  end

  it 'checks that an artist can be destroyed' do
    @artist.destroy
    expect(Artist.count).to eq(0)
  end

end

