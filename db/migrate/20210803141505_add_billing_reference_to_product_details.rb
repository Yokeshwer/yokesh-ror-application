class AddBillingReferenceToProductDetails < ActiveRecord::Migration[6.1]
  def change
    add_reference :product_details, :billing, null: false, foreign_key: true
  end
end
