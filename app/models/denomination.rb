class Denomination < ApplicationRecord

  ############  Validation  ################

  validates :rupees, uniqueness: true, numericality: { greater_than:  0 }
  validates_numericality_of :count, greater_than_or_equal_to: 0
end
