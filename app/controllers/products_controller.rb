class ProductsController < ApplicationController

  before_action :find_product, only: [:edit, :update, :destroy]
  after_action :clear_flash, only: [:create, :update, :destroy]

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
    respond_to do |format|
      format.js
      format.html
    end
  end

  def create
    @product = Product.new(get_products)
    flash[:notice] = "Product created successfully!!!"
    respond_to do |format|
      if @product.save
        format.html
        format.js
      else
        format.html
        format.js
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
    flash[:notice] = "Product updated successfully!!!"
    respond_to do |format|
      if @product.update(get_products)
        format.js
        format.html
      else
        format.js
        format.html
      end
    end
  end

  def destroy
    @product.destroy
    if @product.errors.any?
      flash[:notice] = 'Cannot delete the product, since it is added in some bills'
    else
      flash[:notice] = 'Product deleted successfully!!!'
    end
    respond_to do |format|
      format.js
      format.html
    end
  end
  private
    def get_products
      params.require(:product).permit(:name, :unit_price, :tax_percentage)
    end

    def find_product
      @product = Product.find(params[:id])
    end

    def clear_flash
      flash.discard
    end
end
