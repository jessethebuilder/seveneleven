NA_HEADERS.each do |h|
  eval "json.#{h}(na_store.#{h})"
end
json.image_url(na_store.store_image.url)
json.url(na_store_url(na_store, format: :json))
