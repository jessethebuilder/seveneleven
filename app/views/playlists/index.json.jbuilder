json.array! @playlists do |pl|
  json.id pl.id.to_s
  json.url playlist_url(pl, format: :json)
  json.user do
    json.email pl.user.email
  end
end
