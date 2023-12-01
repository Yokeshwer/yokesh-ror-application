require 'rails_helper'

RSpec.describe "DenominationsControllers", type: :request do
  describe "GET /index" do
    it "renders a index page" do
      get denominations_path
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a new page" do
      get new_denomination_path
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    it "creates a denomination" do
      expect{
      post denominations_path, xhr: true, params: {denomination: {rupees: 500, count: 1000}}
      }.to change(Denomination,:count).by(1)
    end

    it "not creates a denomination" do
      expect{
        post denominations_path, xhr: true, params: {denomination: {rupees: 0, count: 1000}}
      }.to change(Denomination,:count).by(0)
    end
  end

  describe "GET /edit" do
    it "renders edit page" do
      @denomination = Denomination.create(rupees: 500, count: 1000)
      get edit_denomination_path(@denomination)
      expect(response).to be_successful
    end
  end

  describe "PATCH /update" do
    it "updates a denomination" do
      @denomination = Denomination.create(rupees: 500, count: 1000)
      @count = @denomination.count
      patch denomination_path(@denomination), xhr: true, params: { denomination: {rupees: 500, count: 500}}
      expect(@count).not_to eq(Denomination.last.count)
    end

    it "not update the denomination" do
      @denomination = Denomination.create(rupees: 500, count: 1000)
      @count = @denomination.count
      patch denomination_path(@denomination), xhr: true, params: { denomination: {rupees: 0, count: 500}}
      expect(@count).to eq(Denomination.last.count)
    end
  end

  describe "DELETE /destroy" do
    it "destroys a denomination" do
      @denomination = Denomination.create(rupees: 500, count: 1000)
      expect{
        delete denomination_path(@denomination), xhr: true
      }.to change(Denomination,:count).by(-1)
    end
  end
end
