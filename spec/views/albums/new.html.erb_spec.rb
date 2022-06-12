require 'rails_helper'

RSpec.describe "albums/new", type: :view do
  before(:each) do
    assign(:album, Album.new(
      :album_name => "MyString",
      :artist_id => 1,
      :year => 1,
      :album_genre => "MyString",
      :album_priority => "MyString",
      :album_type => "MyString",
      :album_complete => "MyString",
      :album_download => "MyString",
      :current_album_song => "MyString",
      :album_version => "MyString",
      :download_verified => "MyString",
      :download_status => "MyString",
      :rating => 1,
      :normalized_tagged => false,
      :compiliation => false,
      :album_sub_genre1 => "MyString",
      :album_sub_genre2 => "MyString"
    ))
  end

  it "renders new album form" do
    render

    assert_select "form[action=?][method=?]", albums_path, "post" do

      assert_select "input[name=?]", "album[album_name]"

      assert_select "input[name=?]", "album[artist_id]"

      assert_select "input[name=?]", "album[year]"

      assert_select "input[name=?]", "album[album_genre]"

      assert_select "input[name=?]", "album[album_priority]"

      assert_select "input[name=?]", "album[album_type]"

      assert_select "input[name=?]", "album[album_complete]"

      assert_select "input[name=?]", "album[album_download]"

      assert_select "input[name=?]", "album[current_album_song]"

      assert_select "input[name=?]", "album[album_version]"

      assert_select "input[name=?]", "album[download_verified]"

      assert_select "input[name=?]", "album[download_status]"

      assert_select "input[name=?]", "album[rating]"

      assert_select "input[name=?]", "album[normalized_tagged]"

      assert_select "input[name=?]", "album[compiliation]"

      assert_select "input[name=?]", "album[album_sub_genre1]"

      assert_select "input[name=?]", "album[album_sub_genre2]"
    end
  end
end
