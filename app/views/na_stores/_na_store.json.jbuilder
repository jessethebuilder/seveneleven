json.extract! na_store
NA_HEADERS.each do |h|
  eval "json.#{h}(na_store.#{h})"
end
json.url(na_store_url(na_store, format: :json))
