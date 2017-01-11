json.international_stores do
  json.array! @intl_stores, partial: 'intl_stores/intl_store', as: :intl_store
end
