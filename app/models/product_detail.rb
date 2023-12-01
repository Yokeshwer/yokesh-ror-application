class ProductDetail < ApplicationRecord

  #################  Validation  #####################


  validates :quantity, presence: true

  #################   Association  ###################

  belongs_to :billing
  belongs_to :product

end
