require 'rails_helper'

RSpec.describe "albums/show", type: :view do
  before(:each) do
    @album = assign(:album, Album.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Album Name/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/Album Genre/)
    expect(rendered).to match(/Album Priority/)
    expect(rendered).to match(/Album Type/)
    expect(rendered).to match(/Album Complete/)
    expect(rendered).to match(/Album Download/)
    expect(rendered).to match(/Current Album Song/)
    expect(rendered).to match(/Album Version/)
    expect(rendered).to match(/Download Verified/)
    expect(rendered).to match(/Download Status/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/Album Sub Genre1/)
    expect(rendered).to match(/Album Sub Genre2/)
  end
end
