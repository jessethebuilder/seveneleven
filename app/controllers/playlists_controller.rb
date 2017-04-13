class PlaylistsController < ApplicationController
  before_action :set_playlist, only: [:show, :edit, :update, :destroy, :go_live]
  before_action :authenticate_user!, except: [:show, :index]
  before_action :authenticate_user_unless_json!, only: [:show, :index]

  def go_live
    user = @playlist.user
    user.playlists.all.each do |pl|
      pl.update_attribute(:live, false) unless @playlist == pl
    end

    @playlist.update_attribute(:live, true)
    @playlist.push_as_live

    unless params[:show_mine]
      redirect_to playlists_path
    else
      redirect_to playlists_path(show_mine: true)
    end
  end

  def add_to_current
    store_type = params[:store_type]

    if store_type == 'na'
      add_na_store_to_current
    elsif store_type == 'intl'
      add_intl_store_to_current
    else
      puts "*********Invalid Store Type: #{store_type} @ /playlists/add_to_current********"
    end

    render 'update_current'
  end

  def remove_from_current
    store_type = params[:store_type]

    if store_type == 'na'
      remove_na_store_from_current
    elsif store_type == 'intl'
      remove_intl_store_from_current
    else
      puts "*********Invalid Store Type: #{store_type} @ /playlists/remove_from_current********"
    end

    render 'update_current'
  end

private
  def add_na_store_to_current
    current_playlist.na_stores << NaStore.find(params[:store_id])
  end

  def remove_na_store_from_current
    current_playlist.na_stores.delete(NaStore.find(params[:store_id]))
  end

  def add_intl_store_to_current
    current_playlist.intl_stores << IntlStore.find(params[:store_id])
  end

  def remove_intl_store_from_current
    current_playlist.intl_stores.delete(IntlStore.find(params[:store_id]))
  end
public
  # GET /playlists
  # GET /playlists.json
  def index

    respond_to do |format|
      format.html do
        if user_is_admin? && !params[:show_mine]
          # @show_all = true
          @playlists = Playlist.published.order(:user_id => :asc)
        else user_signed_in?
          @playlists = current_user.playlists.published
        end
      end

      format.json do
        @playlists = Playlist.live

      end
    end
  end

  # GET /playlists/1
  # GET /playlists/1.json
  def show
    respond_to do |format|
      format.html { render :edit }
      format.json
    end
  end

  def edit
    if @playlist != current_playlist
      activate_playlist_edit_mode(@playlist)
    end
  end

  def update
    respond_to do |format|
      if @playlist.update(playlist_params)
        deactivate_playlist_edit_mode(@playlist)
        unless params[:skip_flash]
          format.html { redirect_to playlists_url, notice: "#{@playlist.name} was Saved." }
        else
          format.html{ redirect_to playlists_url }
        end
        # format.json { render :show, status: :ok, location: @playlist }
      else
        format.html { render :edit }
        # format.json { render json: @playlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /playlists/1
  # DELETE /playlists/1.json
  def destroy
    @playlist.destroy
    respond_to do |format|
      format.html { redirect_to playlists_url, notice: "#{@playlist.name || 'current draft'} was Deleted." }
      # format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_playlist
      @playlist = Playlist.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def playlist_params
      params.require(:playlist).permit(:user_id, :name, :published)
    end
end
