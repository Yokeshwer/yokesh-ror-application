class CreateBillings < ActiveRecord::Migration[6.1]
  def change
    create_table :billings do |t|
      t.text :email
      t.integer :amount
      t.json :balance, default: {}
      t.float   :without_tax
      t.float   :tax_price
      t.float   :total_bill


      t.timestamps
    end
  end
end
