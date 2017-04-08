INTL_HEADERS.each do |h|
  eval "json.#{h}(intl_store.#{h})"
end
json.image_url(intl_store.fz_image.url)
json.url(intl_store_url(intl_store, format: :json))
