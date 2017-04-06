class NaStoresController < ApplicationController
  before_action :set_na_store, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :authenticate_admin!, only: [:destroy, :edit_all]

  # GET /na_stores
  # GET /na_stores.json
  def index
    order_by = params[:order_by] || "location"
    order_direction = params[:order_direction] || 'asc'
    filter_bys = params[:filter_bys]
    filter_terms = params[:filter_terms]

    if params[:view_all] == 'true'
      count = NaStore.count
    else
      count = 50
    end

    if(filter_bys && filter_terms)
      bys = filter_bys.split(',')
      # .inject(''){ |n, s| s += "#{n} = ?"}
      terms = filter_terms.split(',')
      na_stores = NaStore.where(bys[0] => /#{terms[0]}/i)

      bys.each_with_index do |b, i|
        unless i == 0
          na_stores = na_stores.where(b => /#{terms[i]}/i)
        end
      end

      @na_stores =  na_stores.order(order_by => order_direction).page(params[:page]).per(count)
    else
      @na_stores = NaStore.all.
                          order(order_by => order_direction).
                          page(params[:page]).per(count)
    end
  end

  def edit_all
    order_by = params[:order_by] || "location"
    order_direction = params[:order_direction] || 'asc'
    filter_bys = params[:filter_bys]
    filter_terms = params[:filter_terms]

    # count = NaStore.count
    count = 10

    if(filter_bys && filter_terms)
      bys = filter_bys.split(',')
      # .inject(''){ |n, s| s += "#{n} = ?"}
      terms = filter_terms.split(',')
      na_stores = NaStore.where(bys[0] => /#{terms[0]}/i)

      bys.each_with_index do |b, i|
        unless i == 0
          na_stores = na_stores.where(b => /#{terms[i]}/i)
        end
      end

      @na_stores =  na_stores.order(order_by => order_direction).page(params[:page]).per(count)
    else
      @na_stores = NaStore.all.
                          order(order_by => order_direction).
                          page(params[:page]).per(count)
    end
  end

  # GET /na_stores/1
  # GET /na_stores/1.json
  def show
  end

  # GET /na_stores/new
  def new
    @na_store = NaStore.new
  end

  # GET /na_stores/1/edit
  def edit
  end

  # POST /na_stores
  # POST /na_stores.json
  def create
    @na_store = NaStore.new(na_store_params)

    respond_to do |format|
      if @na_store.save
        format.html { redirect_to @na_store, notice: 'Na store was successfully created.' }
        format.json { render :show, status: :created, location: @na_store }
      else
        format.html { render :new }
        format.json { render json: @na_store.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /na_stores/1
  # PATCH/PUT /na_stores/1.json
  def update
    respond_to do |format|
      if @na_store.update(na_store_params)
        format.html { redirect_to @na_store, notice: 'Na store was successfully updated.' }
        format.json { render :show, status: :ok, location: @na_store }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @na_store.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /na_stores/1
  # DELETE /na_stores/1.json
  def destroy
    @na_store.destroy
    respond_to do |format|
      format.html { redirect_to na_stores_url, notice: "North American store #{@na_store.location} was DELETED"}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_na_store
      @na_store = NaStore.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def na_store_params
      params.require(:na_store).permit(:nblc_highlight, :nblc_member_photo, :nblc_member, :file_name, :location,
                                       :fz_name, :zone_code, :zone_name, :market_code, :market, :market_manager,
                                       :field_consultant_name, :store_manager, :store_type, :address, :city,
                                       :state_or_province, :postal_code, :country, :open_status_code,
                                       :open_date, :close_date, :vicinity, :phone_number, :cdc_code, :cdc_name,
                                       :wholesale_center, :dma_code, :dma_name, :wholesale_center, :alcohol_flag,
                                       :liquor_flag, :gas_flag, :gas_brand, :bcp, :store_name, :store_type, :region, :fc_email,
                                       :fz_image, :fz_image_cache, :remote_fz_image_url, :remove_fz_image)
    end
end
