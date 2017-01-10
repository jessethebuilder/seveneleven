json.north_american_stores do
  json.array! @na_stores, partial: 'na_stores/na_store', as: :na_store
end
