require 'rails_helper'

describe "NA Stores Requests", type: :feature, js: true do
  before(:each) do
    @user = create :user
    manual_login(@user)
  end

  describe "Creating a Store" do
    specify "Saving a store" do
      within("#top_nav"){ click_link "North American" }
      within(".quick_options"){ click_link "Add Store" }
      fill_in_na_store
      expect{ click_button "Save" }.to change{ NaStore.count }.by(1)
    end
  end
end
