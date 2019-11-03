class ExpenseList < ApplicationRecord

    attr_accessor :multi_date_from
    attr_accessor :multi_date_to
    attr_accessor :include_weekend

    belongs_to :expense
    belongs_to :employee
    belongs_to :project

    def total_claim
        @sum = self.fuel_claim + self.toll_claim + self.parking_claim + self.allowance_claim + self.medical_claim + self.others_claim
        return @sum
    end

end