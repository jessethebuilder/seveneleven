class IntlStoresController < ApplicationController
  before_action :set_intl_store, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :authenticate_admin!, only: [:destroy]

  # GET /intl_stores
  # GET /intl_stores.json
  def index
    order_by = params[:order_by] || "country"
    order_direction = params[:order_direction] || 'asc'
    filter_bys = params[:filter_bys]
    filter_terms = params[:filter_terms]

    if(filter_bys && filter_terms)
      bys = filter_bys.split(',')
      # .inject(''){ |n, s| s += "#{n} = ?"}
      terms = filter_terms.split(',')
      intl_stores = IntlStore.where(bys[0] => /#{terms[0]}/i)

      bys.each_with_index do |b, i|
        unless i == 0
          intl_stores = intl_stores.where(b => /#{terms[i]}/i)
        end
      end

      @intl_stores =  intl_stores.order(order_by => order_direction).page(params[:page]).per(50)
    else
      @intl_stores = IntlStore.all.
                          order(order_by => order_direction).
                          page(params[:page]).per(50)
    end
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
        # format.json { render :show, status: :created, location: @intl_store }
      else
        format.html { render :new }
        # format.json { render json: @intl_store.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /intl_stores/1
  # PATCH/PUT /intl_stores/1.json
  def update
    respond_to do |format|
      if @intl_store.update(intl_store_params)
        format.html { redirect_to @intl_store, notice: 'Intl store was successfully updated.' }
        # format.json { render :show, status: :ok, location: @intl_store }
      else
        format.html { render :edit }
        # format.json { render json: @intl_store.errors, status: :unprocessable_entity }
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
                                         :lat_long, :lat, :long, :pin_address_for_store_drop,
                                         :store_image, :remote_store_image_url, :store_image_cache)
    end
end
