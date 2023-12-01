class AddProductReferenceToProductDetails < ActiveRecord::Migration[6.1]
  def change
    add_reference :product_details, :product, null: false, foreign_key: true
  end
end
