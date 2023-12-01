class DenominationsController < ApplicationController

  before_action :get_denomination_id, only: [:edit, :update, :destroy]
  after_action :clear_flash, only: [:create, :update, :destroy]

  def index
    @denominations = Denomination.all.order(rupees: :desc)
  end

  def new
    @denomination = Denomination.new
    respond_to do |format|
      format.js
      format.html
    end
  end

  def create
    @denomination = Denomination.new(get_denomination)
    flash[:notice] = "Denomination created successfully!!!"
    respond_to do |format|
      if @denomination.save
        format.js
        format.html
      else
        format.js
        format.html
      end
    end

  end

  def edit
    respond_to do |format|
      format.js
      format.html
    end
  end

  def update
    flash[:notice] = "Denomination updated successfully!!!"
    respond_to do |format|
      if @denomination.update(get_denomination)
        format.js
        format.html
      else
        format.js
        format.html
      end
    end
  end

  def destroy
    @denomination.destroy
    flash[:notice] = "Denomination deleted successfully!!!"
    respond_to do |format|
      format.js
      format.html
    end
  end

  private
    def get_denomination
      params.require(:denomination).permit(:rupees,:count)
    end

    def get_denomination_id
      @denomination = Denomination.find(params[:id])
    end

    def clear_flash
      flash.discard
    end
end
