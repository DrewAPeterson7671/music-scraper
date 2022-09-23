require 'rails_helper'

RSpec.describe "annual_ranks/show", type: :view do
  before(:each) do
    @annual_rank = assign(:annual_rank, AnnualRank.create!(
      :year => 2,
      :rank => 3,
      :source => "Source",
      :rank_artist => "Rank Artist",
      :rank_track => "Rank Track",
      :rank_album => "Rank Album"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/Source/)
    expect(rendered).to match(/Rank Artist/)
    expect(rendered).to match(/Rank Track/)
    expect(rendered).to match(/Rank Album/)
  end
end
