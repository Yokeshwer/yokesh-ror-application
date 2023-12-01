class CreateProductDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :product_details do |t|
      t.integer :quantity
      t.float :purchased_price
      t.float :tax_payable_for_item
      t.float :total_price_of_item

      t.timestamps
    end
  end
end
