module PlaylistsHelper
  def is_in_current_playlist?(store)
    store_type = store.class.name.pluralize.underscore
    current_playlist.send(store_type).include?(store)
  end
end
