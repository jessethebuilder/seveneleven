class StoreListsController < ApplicationController
  before_action :set_store_list, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def add_to_current
    store_type = params[:store_type]

    if store_type == 'na'
      add_na_store_to_current
    elsif store_type == 'intl'
      add_intl_store_to_current
    else
      puts "*********Invalid Store Type: #{store_type} @ /store_lists/add_to_current********"
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
      puts "*********Invalid Store Type: #{store_type} @ /store_lists/remove_from_current********"
    end

    render 'update_current'
  end

private
  def add_na_store_to_current
    current_store_list.na_stores << NaStore.find(params[:store_id])
  end

  def remove_na_store_from_current
    current_store_list.na_stores.delete(NaStore.find(params[:store_id]))
  end

  def add_intl_store_to_current
    current_store_list.intl_stores << IntlStore.find(params[:store_id])
  end

  def remove_intl_store_from_current
    current_store_list.intl_stores.delete(IntlStore.find(params[:store_id]))
  end
public


  # GET /store_lists
  # GET /store_lists.json
  def index
    if user_is_admin?
      @store_lists = StoreList.where(published: true).order(:user_id)
    else
      @store_lists = current_user.store_lists.where(published: true)
    end
  end

  # GET /store_lists/1
  # GET /store_lists/1.json
  def show
    respond_to do |format|
      format.html { render :edit }
      format.json
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @store_list.update(store_list_params)
        u = current_user
        csl = u.current_store_list.dup
        u.current_store_list.remove
        u.store_lists << csl
        u.current_store_list = StoreList.new 
        u.save!

        format.html { redirect_to store_lists_url, notice: "#{@store_list.name} was Published." }
        # format.json { render :show, status: :ok, location: @store_list }
      else
        format.html { render :edit }
        # format.json { render json: @store_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /store_lists/1
  # DELETE /store_lists/1.json
  def destroy
    @store_list.destroy
    respond_to do |format|
      format.html { redirect_to store_lists_url, notice: "#{@store_list.name} was destroyed." }
      # format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_store_list
      @store_list = StoreList.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def store_list_params
      params.require(:store_list).permit(:user_id, :name, :published)
    end
end
