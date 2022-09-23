require 'rails_helper'

RSpec.describe "annual_ranks/index", type: :view do
  before(:each) do
    assign(:annual_ranks, [
      AnnualRank.create!(
        :year => 2,
        :rank => 3,
        :source => "Source",
        :rank_artist => "Rank Artist",
        :rank_track => "Rank Track",
        :rank_album => "Rank Album"
      ),
      AnnualRank.create!(
        :year => 2,
        :rank => 3,
        :source => "Source",
        :rank_artist => "Rank Artist",
        :rank_track => "Rank Track",
        :rank_album => "Rank Album"
      )
    ])
  end

  it "renders a list of annual_ranks" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "Source".to_s, :count => 2
    assert_select "tr>td", :text => "Rank Artist".to_s, :count => 2
    assert_select "tr>td", :text => "Rank Track".to_s, :count => 2
    assert_select "tr>td", :text => "Rank Album".to_s, :count => 2
  end
end
