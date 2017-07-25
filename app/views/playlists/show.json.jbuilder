json.playlist do
  json.url(playlist_url(@playlist, format: :json))

  json.live(@playlist.live)

  json.user do
    json.email(@playlist.user.email)
  end

  json.na_stores do
    json.array! @na_stores do |na|
      json.partial! 'na_stores/na_store.json.jbuilder',  locals: {na_store: na}
    end
  end

  json.intl_stores do
    json.array! @intl_stores do |intl|
      json.partial! 'intl_stores/intl_store.json.jbuilder', locals: {intl_store: intl}
    end
  end
end
