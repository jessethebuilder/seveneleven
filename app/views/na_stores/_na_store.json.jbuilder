NA_HEADERS.each do |h|
  eval "json.#{h}(na_store.#{h})"
end
json.fz_image(na_store.fz_image)
json.url(na_store_url(na_store, format: :json))
