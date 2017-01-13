require 'rails_helper'

describe "Editing Playlist Requests", type: :feature, js: :true do
  let(:na_store){ create :na_store }
  let(:intl_store){ create :intl_store }

  before(:each) do
    @user = create :user
    manual_login(@user)
  end

  specify 'When existing Playist is selected for edit, it becomes Current Playlist' do
    name = "A Name To rmembbjaerrj d--d-f-f-ad fn39nba;"
    @user.playlists << build(:playlist, :name => name)
    visit '/playlists'
    save_and_open_page
    find(:css, '.edit_playlist_link:first-child').click
    find(:css, '.current_playlist_link').click
    find(:css, '#playlist_name').value.should == name
  end
end
