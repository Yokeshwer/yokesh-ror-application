require 'rails_helper'

RSpec.describe "ProductsControllers", type: :request do
  describe "GET /index" do
    it "gets the index page" do
      get products_path
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "gets the new page" do
      get new_product_path
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    it "create new product" do
      expect{
      post products_path, xhr: true, params: {product: {name: 'Bedsheet',unit_price: 300,tax_percentage: 1}}
      }.to change(Product,:count).by(1)
    end

    it "not creates a product" do
      expect{
      @product = Product.create(name: 'Bedsheet',unit_price: 300,tax_percentage: 1)
      }.to change(Product,:count).by(1)
      expect{
        @product = Product.create(name: 'Bedsheet',unit_price: 300,tax_percentage: 1)
      }.to change(Product,:count).by(0)
    end
  end

  describe "GET /edit" do
    it "gets the edit page" do
      @product = Product.create(name: 'Bedsheet',unit_price: 300,tax_percentage: 1)
      get edit_product_path(@product), xhr: true
      expect(response).to be_successful
    end
  end

  describe "PUT /update" do
    it "update the product" do
      @product = Product.create(name: 'Bedsheet',unit_price: 300,tax_percentage: 1)
      @name = @product.name
      patch product_url(@product), xhr: true, params: {product: {name: 'Bed',unit_price: 300,tax_percentage: 1}}
      expect(@name).not_to eq(Product.last.name)
    end

    it "not update the product" do
      @product = Product.create(name: 'Bedsheet',unit_price: 300,tax_percentage: 1)
      @name = @product.name
      patch product_url(@product), xhr: true, params: {product: {name: 'Bed',unit_price: 300,tax_percentage: 0}}
      expect(@name).to eq(Product.last.name)
    end
  end

  describe "Delete /destroy" do
    it "destroys the product" do
      @product = Product.create(name: 'Bedsheet',unit_price: 300,tax_percentage: 1)
      expect{
      delete product_path(@product), xhr: true
      }.to change(Product,:count).by(-1)
    end
  end
end
