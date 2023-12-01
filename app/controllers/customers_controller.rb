class CustomersController < ApplicationController
  include Pagy::Backend

  before_action :get_billing_by_id, except: :index

  def index
    @pagy, @customers = params[:email].present? ? pagy(Billing.where(email: params[:email]).order(created_at: 'DESC'), items: 10) : pagy(Billing.all.order(created_at: 'DESC'), items: 10)
  end

  def show
    @product_details  = @billing.product_details.includes(:product)
  end

  def send_email
    PurchaseMailer.show_details(@billing).deliver

    redirect_to customer_path(@billing), notice: "Email sent successfully!!!"
  end

  private
    def get_billing_by_id
      @billing = Billing.find(params[:id])
    end
end
