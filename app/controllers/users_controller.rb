class UsersController < ApplicationController
  before_action :set_intl_store, only: [:show, :edit, :update, :destroy]
  before_action :authenticte_admin!

  def index
    @users = User.all
  end

  # GET /intl_stores/new
  def new
    @user = User.new
  end

  # GET /intl_stores/1/edit
  def edit
  end

  # POST /intl_stores
  # POST /intl_stores.json
  def create
    @user = User.new(intl_store_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'Intl store was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(intl_store_params)
        format.html { redirect_to @user, notice: 'Intl store was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to intl_stores_url, notice: 'Intl store was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password, :admin)
    end
end
