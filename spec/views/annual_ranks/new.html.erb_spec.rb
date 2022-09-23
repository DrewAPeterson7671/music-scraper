require 'rails_helper'

RSpec.describe "annual_ranks/new", type: :view do
  before(:each) do
    assign(:annual_rank, AnnualRank.new(
      :year => 1,
      :rank => 1,
      :source => "MyString",
      :rank_artist => "MyString",
      :rank_track => "MyString",
      :rank_album => "MyString"
    ))
  end

  it "renders new annual_rank form" do
    render

    assert_select "form[action=?][method=?]", annual_ranks_path, "post" do

      assert_select "input[name=?]", "annual_rank[year]"

      assert_select "input[name=?]", "annual_rank[rank]"

      assert_select "input[name=?]", "annual_rank[source]"

      assert_select "input[name=?]", "annual_rank[rank_artist]"

      assert_select "input[name=?]", "annual_rank[rank_track]"

      assert_select "input[name=?]", "annual_rank[rank_album]"
    end
  end
end
