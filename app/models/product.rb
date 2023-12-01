class Product < ApplicationRecord

  ##########  Validation  ###############

  validates :name, presence: true, uniqueness: true
  validates_numericality_of :unit_price, greater_than: 0
  validates_numericality_of :tax_percentage, greater_than: 0
  validate :whether_it_has_child

  def whether_it_has_child
    if self.product_details.size > 0
      errors.add(:product, " used in existing customers bill, so can't update")
    end
  end

  ###########  Association ##############

  has_many :product_details, :dependent => :restrict_with_error
  has_many :billings, through:  :product_details
end
