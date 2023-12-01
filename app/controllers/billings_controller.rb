class BillingsController < ApplicationController

  def index
    if Product.count==0
      redirect_to products_path, alert: 'You have 0 products in billing. So please create one product for billing!!!'
    end
    @new_one = Billing.new
    @product = Product.first
    @products = Product.all
  end


  def product_details
    @product = Product.find(params[:id])
    respond_to do |format|
      format.json { render json: {id: @product.id,unit_price: @product.unit_price,tax: @product.tax_percentage} }
    end

  end

  def create
    @product = Product.first
    @new_one = Billing.new(get_billing)
    respond_to do |format|
      if @new_one.save
        PurchaseMailer.show_details(@new_one).deliver
        format.js { redirect_to customer_path(@new_one), notice: "Customer details saved successfully!!!" }
        format.html
      else
        format.js
        format.html
      end
    end
  end

  private
    def get_billing
      params.require(:billing).permit(:email, :amount, :without_tax, :tax_price, :total_bill, product_details_attributes: [:product_id,:name, :quantity, :unit_price,:purchased_price, :tax_percentage_for_item, :tax_payable_for_item, :total_price_of_item])
    end

end
