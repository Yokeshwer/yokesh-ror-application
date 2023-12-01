class Billing < ApplicationRecord

  ####################   Validations   #############################

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates_format_of :email, with: EMAIL_REGEX
  validates :amount, numericality: { greater_than: 0, only_integer: true }
  validate :paid_amount


  def paid_amount
    if self.product_details.size < 1
      errors.add(:product,'list is less than 1')
    else
      self.amount=0 if self.amount.nil?
      if self.amount >= self.total_bill
        @amount = self.amount - self.total_bill
        @balance = {}
        @sum     = 0
        Denomination.all.order(rupees: :desc).each do |denomination|
          if @amount >= denomination.rupees
            @count = @amount/denomination.rupees

            if denomination.count >=  @count
              @balance[denomination.rupees] =  @count.to_i
              @amount %= denomination.rupees
              @sum += (denomination.rupees*@count.to_i)
            else
              @balance[denomination.rupees] = denomination.count
              @amount -= (denomination.rupees * denomination.count)
              @sum += (denomination.rupees*denomination.count)
            end
          end
        end

        if @sum==self.amount-self.total_bill
          self.balance = @balance
          @balance.each do |rupees,count|
            @denomination = Denomination.find_by_rupees(rupees)
            @denomination.update(count: @denomination.count-count)
          end
        else
          errors.add(:balance,' not enough in shop')
        end
      else
        errors.add(:total_bill, "- Paid amount is less than purchased amount")
      end
    end
  end



  ####################  Association    ############################

  has_many :product_details, dependent: :destroy
  has_many :products, through: :product_details
  accepts_nested_attributes_for :product_details

end
