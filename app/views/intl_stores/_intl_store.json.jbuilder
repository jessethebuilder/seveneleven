json.extract! intl_store
INTL_HEADERS.each do |h|
  eval "json.#{h}(intl_store.#{h})"
end
json.url(intl_store_url(intl_store, format: :json))
