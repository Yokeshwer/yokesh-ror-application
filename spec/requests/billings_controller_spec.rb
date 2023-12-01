require 'rails_helper'

RSpec.describe "BillingsControllers", type: :request do
  describe "GET /index" do
    it "renders the index page" do
      if Product.count>0
        get billings_path
        expect(response).to be_successful
      else
        get billings_path
        expect(response).to redirect_to(products_path)
      end
    end
  end

  describe "POST /create" do
    it "create new billing" do
      @product = Product.create(name: 'Bed',unit_price: 2000,tax_percentage: 1)
      expect{
      post billings_path, xhr: true, params: {billing: { email: 'b@gmail.com', without_tax: 2000, tax_price: 20, total_bill: 2020, amount:2020, product_details_attributes: [{quantity: 1, purchased_price: 2000.0, tax_payable_for_item: 20, total_price_of_item: 2020, product_id: @product.id}] }}
      }.to change(Billing,:count).by(1)

      expect{
        post billings_path, xhr: true, params: {billing: { email: 'b@gmail.com', without_tax: 4000, tax_price: 40, total_bill: 4040, amount:4040, product_details_attributes: [{quantity: 1, purchased_price: 2000.0, tax_payable_for_item: 20, total_price_of_item: 2020, product_id: @product.id},{quantity: 1, purchased_price: 2000.0, tax_payable_for_item: 20, total_price_of_item: 2020, product_id: @product.id}] }}
      }.to change(ProductDetail,:count).by(2)
    end

    it "not create a bill" do
      @product = Product.create(name: 'Bed',unit_price: 2000,tax_percentage: 1)
      expect{
        post billings_path, xhr: true, params: {billing: { email: 'gmail.com', without_tax: 2000, tax_price: 20, total_bill: 2020, amount:2020, product_details_attributes: [{quantity: 1, purchased_price: 2000.0, tax_payable_for_item: 20, total_price_of_item: 2020, product_id: @product.id}] }}
      }.to change(Billing,:count).by(0)
    end
  end

  describe "POST /product_details" do
    it "returns json response" do
      @product = Product.create(name: 'Trial',unit_price: 2000,tax_percentage: 1)
      puts @product.id
      get product_details_billing_path(@product.id),params: { :format => 'json', name: 'Trial'}
      @values = JSON.parse(response.body)
      expect(@values['id']).to eq(@product.id)
      expect(@values['unit_price']).to eq(@product.unit_price)
      expect(@values['tax']).to eq(@product.tax_percentage)
    end
  end
end
