# require 'rails_helper'
#
# describe "Playlist Requests", type: :feature, js: :true do
#   let(:na_store){ create :na_store }
#   let(:intl_store){ create :intl_store }
#   before(:each) do
#     @user = create :user
#     manual_login(@user)
#   end
#
#   describe "User Playlist" do
#     specify "User should start with blank playlist" do
#       @user.playlists.count.should == 1
#     end
#
#     describe "Adding Stores" do
#       specify "User can add NaStores" do
#         na_store.save!
#         within('#top_nav'){ click_link "North American" }
#         wait_until{ page.has_css?('.store_select:first-child') }
#
#         find(:css, '.store_select:first-child').set(true)
#         @user.playlists.first.na_stores.count.should == 1
#         @user.playlists.first.na_stores.first.should == na_store
#       end
#
#       specify "User can add InlStores" do
#         intl_store.save!
#         within('#top_nav'){ click_link "International" }
#         wait_until{ page.has_css?('.store_select:first-child') }
#         find(:css, '.store_select:first-child').set(true)
#         @user.playlists.first.intl_stores.count.should == 1
#         @user.playlists.first.intl_stores.first.should == intl_store
#       end
#
#       specify "If user adds an NaStore, the store remains checked after new request" do
#         @user.playlists.first.na_stores << na_store
#         visit('/na_stores')
#         wait_until{ page.has_css?('.store_select:first-child') }
#         find(:css, '.store_select:first-child').should be_checked
#       end
#
#       specify "Same: IntlStore" do
#         @user.playlists.first.intl_stores << intl_store
#         visit '/intl_stores'
#         wait_until{ page.has_css?('.store_select:first-child') }
#         find(:css, '.store_select:first-child').should be_checked
#       end
#
#       specify "Added NaStores will be checked on Current Playlist" do
#         @user.playlists.first.na_stores << na_store
#         find(:css, '.current_playlist_link').click
#         wait_until{ page.has_css?('.store_select:first-child') }
#         find(:css, '.store_select:first-child').should be_checked
#       end
#
#       specify "Same: IntlStore" do
#         @user.playlists.first.intl_stores << intl_store
#         find(:css, '.current_playlist_link').click
#         wait_until{ page.has_css?('.store_select:first-child') }
#         find(:css, '.store_select:first-child').should be_checked
#       end
#
#       it 'should incremeent when IntlStore is added' do
#         intl_store.save!
#         visit '/intl_stores'
#         wait_until{ page.has_css?('.store_select:first-child') }
#         find(:css, '#current_playlist_box').has_content?('0/0').should == true
#         find(:css, '.store_select:first-child').set true
#         find(:css, '#current_playlist_box').has_content?('0/1').should == true
#       end
#
#       it 'Same: NaStore' do
#         na_store.save!
#         visit '/na_stores'
#         wait_until{ page.has_css?('.store_select:first-child') }
#         find(:css, '#current_playlist_box').has_content?('0/0').should == true
#         find(:css, '.store_select:first-child').set true
#         find(:css, '#current_playlist_box').has_content?('1/0').should == true
#       end
#     end # Adding Stores
#
#     describe 'Removing Stores' do
#       specify "Unchecking a store will remove it from Playlist" do
#         @user.playlists.first.na_stores << na_store
#         visit '/na_stores'
#         wait_until{ page.has_css?('.store_select:first-child') }
#         find(:css, '.store_select:first-child').set false
#         @user.playlists.first.na_stores.count.should == 0
#       end
#
#       specify "Same: IntlStore" do
#         @user.playlists.first.intl_stores << intl_store
#         visit '/intl_stores'
#         wait_until{ page.has_css?('.store_select:first-child') }
#         find(:css, '.store_select:first-child').set false
#         @user.playlists.first.intl_stores.count.should == 0
#       end
#
#       it 'should de-incremeent when IntlStore is removed' do
#         @user.playlists.first.intl_stores << intl_store
#         visit '/intl_stores'
#         wait_until{ page.has_css?('.store_select:first-child') }
#         find(:css, '#current_playlist_box').has_content?('0/1').should == true
#         find(:css, '.store_select:first-child').set false
#         find(:css, '#current_playlist_box').has_content?('0/0').should == true
#       end
#
#       it 'Same: NaStore' do
#         @user.playlists.first.na_stores << na_store
#         visit '/na_stores'
#         wait_until{ page.has_css?('.store_select:first-child') }
#         find(:css, '#current_playlist_box').has_content?('1/0').should == true
#         find(:css, '.store_select:first-child').set false
#         find(:css, '#current_playlist_box').has_content?('0/0').should == true
#       end
#     end # Removing Stores
#
#     describe 'Saving Playlists' do
#       specify 'Playlists should not save w/o Name' do
#         find(:css, ".current_playlist_link").click
#         click_button "Save"
#         page.has_content?("Name cannot be blank").should == true
#       end
#
#       specify 'Saving Current Playlist should Create a new one' do
#         find(:css, ".current_playlist_link").click
#         fill_in_playlist
#         expect{ click_button "Save" }.to change{ @user.playlists.count }.by(1)
#       end
#
#       specify "Saved Playlist should be added to User Playlists" do
#         find(:css, ".current_playlist_link").click
#         fill_in_playlist
#         name = "A Special Named,am993madk'g"
#         fill_in "Name", with: name
#         click_button "Save"
#         within('#top_nav'){ click_link "Playlists" }
#         page.should have_content name
#       end
#     end # Saving Playlists
#   end
# end
