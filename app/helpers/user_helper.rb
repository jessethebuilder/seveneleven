module UserHelper
  def authenticate_admin!
    unless user_is_admin?
      redirect_to root_path, alert: "You must be an admin to access that page"
    end
  end

  def user_is_admin?
    user_signed_in? && current_user.admin?
  end

  def session_playlist
    id = session[:current_playlist_id]

    if id
      begin
        Playlist.find(id)
      rescue
        session[:current_playlist_id] = false
      end
    else
      nil
    end
  end

  def current_playlist
    if user_signed_in?
      session_playlist || current_user.playlists.unpublished.first || build_current_playlist
    end
  end

  def build_current_playlist
    current_user.playlists << Playlist.new
    current_user.save!
    current_user.playlists.last
  end

  def activate_playlist_edit_mode(playlist)
    session[:current_playlist_id] = playlist.id
    # playlist = session_playlist
    # playlist.update(:published, false) if playlist
  end

  def deactivate_playlist_edit_mode
    session[:current_playlist_id] = nil
    # playlist = session_playlist
    # playlist.update(:published, true) if playlist
  end

  def in_playlist_edit_mode?
    session[:current_playlist_id] ? true : false
  end
end
