json.name @playlist.name
json.north_american_stores do
  json.array!(@playlist.na_stores, partial: 'na_stores/na_store', as: :na_store)
end
json.international_stores do
  json.array!(@playlist.intl_stores, partial: 'intl_stores/intl_store', as: :intl_store)
end
