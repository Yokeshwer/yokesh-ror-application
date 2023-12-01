class PurchaseMailer < ApplicationMailer
  def show_details(products)
    @details = products
    mail(to: products.email, subject: 'Thanks for purchasing')
  end
end
