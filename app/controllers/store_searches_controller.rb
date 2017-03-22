class StoreSearchesController < ApplicationController
  def show
    # Just he id param of typical rescourceful routing.
    search = params['id']


    @na_stores = []

    NA_HEADERS.each do |nh|
      stores = NaStore.where(nh => /#{search}/i)
      stores.each do |s|
        @na_stores << s
      end
    end
    @na_stores = @na_stores.uniq

    @intl_stores = []

    INTL_HEADERS.each do |ih|
      stores = IntlStore.where(ih => /#{search}/i)
      stores.each do |s|
        @intl_stores << s
      end
    end
    @intl_stores = @intl_stores.uniq

  end
end
