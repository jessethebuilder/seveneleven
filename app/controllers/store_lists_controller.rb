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
    @store_lists = StoreList.all
  end

  # GET /store_lists/1
  # GET /store_lists/1.json
  def show
  end

  # GET /store_lists/new
  def new
    @store_list = StoreList.new
  end

  # GET /store_lists/1/edit
  def edit
  end

  # POST /store_lists
  # POST /store_lists.json
  def create
    @store_list = StoreList.new(store_list_params)

    respond_to do |format|
      if @store_list.save
        format.html { redirect_to @store_list, notice: 'Store list was successfully created.' }
        format.json { render :show, status: :created, location: @store_list }
      else
        format.html { render :new }
        format.json { render json: @store_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /store_lists/1
  # PATCH/PUT /store_lists/1.json
  def update
    respond_to do |format|
      if @store_list.update(store_list_params)
        format.html { redirect_to @store_list, notice: 'Store list was successfully updated.' }
        format.json { render :show, status: :ok, location: @store_list }
      else
        format.html { render :edit }
        format.json { render json: @store_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /store_lists/1
  # DELETE /store_lists/1.json
  def destroy
    @store_list.destroy
    respond_to do |format|
      format.html { redirect_to store_lists_url, notice: 'Store list was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_store_list
      @store_list = StoreList.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def store_list_params
      params.require(:store_list).permit(:user_id, :name)
    end
end
