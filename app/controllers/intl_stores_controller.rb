class IntlStoresController < ApplicationController
  before_action :set_intl_store, only: [:show, :edit, :update, :destroy]

  # GET /intl_stores
  # GET /intl_stores.json
  def index
    @intl_stores = IntlStore.all
  end

  # GET /intl_stores/1
  # GET /intl_stores/1.json
  def show
  end

  # GET /intl_stores/new
  def new
    @intl_store = IntlStore.new
  end

  # GET /intl_stores/1/edit
  def edit
  end

  # POST /intl_stores
  # POST /intl_stores.json
  def create
    @intl_store = IntlStore.new(intl_store_params)

    respond_to do |format|
      if @intl_store.save
        format.html { redirect_to @intl_store, notice: 'Intl store was successfully created.' }
        format.json { render :show, status: :created, location: @intl_store }
      else
        format.html { render :new }
        format.json { render json: @intl_store.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /intl_stores/1
  # PATCH/PUT /intl_stores/1.json
  def update
    respond_to do |format|
      if @intl_store.update(intl_store_params)
        format.html { redirect_to @intl_store, notice: 'Intl store was successfully updated.' }
        format.json { render :show, status: :ok, location: @intl_store }
      else
        format.html { render :edit }
        format.json { render json: @intl_store.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /intl_stores/1
  # DELETE /intl_stores/1.json
  def destroy
    @intl_store.destroy
    respond_to do |format|
      format.html { redirect_to intl_stores_url, notice: 'Intl store was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_intl_store
      @intl_store = IntlStore.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def intl_store_params
      params.require(:intl_store).permit(:country, :founded, :stores, :fun_fact, :video, :first_location,
                                         :lat_long, :lat, :long, :pin_address_for_store_drop)
    end
end
