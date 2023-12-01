require 'rails_helper'

RSpec.describe "CustomersControllers", type: :request do
  describe "GET /index" do
    it "renders the index page" do
      @product = Product.create(name: 'Bed',unit_price: 2000,tax_percentage: 1)
      for billing in 1..12 do
        Billing.create(email: 'b@gmail.com', without_tax: 2000, tax_price: 20, total_bill: 2020, amount:2020, product_details_attributes: [{quantity: 1, purchased_price: 2000.0, tax_payable_for_item: 20, total_price_of_item: 2020, product_id: @product.id}])
      end
      get customers_path, params: { page: 1 }
      expect(assigns(:customers).map(&:id).count).to eq(10)
      get customers_path, params: { page: 2 }
      expect(assigns(:customers).map(&:id).count).to eq(2)
    end
  end

  describe "GET /show" do
    it "renders the show page" do
      @product = Product.create(name: 'Bed',unit_price: 2000,tax_percentage: 1)
      expect{
        post billings_path, xhr: true, params: {billing: { email: 'b@gmail.com', without_tax: 2000, tax_price: 20, total_bill: 2020, amount:2020, product_details_attributes: [{quantity: 1, purchased_price: 2000.0, tax_payable_for_item: 20, total_price_of_item: 2020, product_id: @product.id}] }}
      }.to change(Billing,:count).by(1)
      get customer_path(Billing.last)
      expect(response).to be_successful
    end
  end

  describe "/send_email" do
    it "sents a email" do
      @product = Product.create(name: 'Bed',unit_price: 2000,tax_percentage: 1)
      Billing.create(email: 'b@gmail.com', without_tax: 2000, tax_price: 20, total_bill: 2020, amount:2020, product_details_attributes: [{quantity: 1, purchased_price: 2000.0, tax_payable_for_item: 20, total_price_of_item: 2020, product_id: @product.id}])
      expect{
      post send_email_customer_path(Billing.last)
      }.to change{ActionMailer::Base.deliveries.count}.by(1)
    end
  end

end
