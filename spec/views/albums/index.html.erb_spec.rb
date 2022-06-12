require 'rails_helper'

RSpec.describe "albums/index", type: :view do
  before(:each) do
    assign(:albums, [
      Album.create!(
        :album_name => "Album Name",
        :artist_id => 2,
        :year => 3,
        :album_genre => "Album Genre",
        :album_priority => "Album Priority",
        :album_type => "Album Type",
        :album_complete => "Album Complete",
        :album_download => "Album Download",
        :current_album_song => "Current Album Song",
        :album_version => "Album Version",
        :download_verified => "Download Verified",
        :download_status => "Download Status",
        :rating => 4,
        :normalized_tagged => false,
        :compiliation => false,
        :album_sub_genre1 => "Album Sub Genre1",
        :album_sub_genre2 => "Album Sub Genre2"
      ),
      Album.create!(
        :album_name => "Album Name",
        :artist_id => 2,
        :year => 3,
        :album_genre => "Album Genre",
        :album_priority => "Album Priority",
        :album_type => "Album Type",
        :album_complete => "Album Complete",
        :album_download => "Album Download",
        :current_album_song => "Current Album Song",
        :album_version => "Album Version",
        :download_verified => "Download Verified",
        :download_status => "Download Status",
        :rating => 4,
        :normalized_tagged => false,
        :compiliation => false,
        :album_sub_genre1 => "Album Sub Genre1",
        :album_sub_genre2 => "Album Sub Genre2"
      )
    ])
  end

  it "renders a list of albums" do
    render
    assert_select "tr>td", :text => "Album Name".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "Album Genre".to_s, :count => 2
    assert_select "tr>td", :text => "Album Priority".to_s, :count => 2
    assert_select "tr>td", :text => "Album Type".to_s, :count => 2
    assert_select "tr>td", :text => "Album Complete".to_s, :count => 2
    assert_select "tr>td", :text => "Album Download".to_s, :count => 2
    assert_select "tr>td", :text => "Current Album Song".to_s, :count => 2
    assert_select "tr>td", :text => "Album Version".to_s, :count => 2
    assert_select "tr>td", :text => "Download Verified".to_s, :count => 2
    assert_select "tr>td", :text => "Download Status".to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "Album Sub Genre1".to_s, :count => 2
    assert_select "tr>td", :text => "Album Sub Genre2".to_s, :count => 2
  end
end
