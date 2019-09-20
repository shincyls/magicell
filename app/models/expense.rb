class Expense < ApplicationRecord

    belongs_to :employee
    has_many :expense_approvals
    has_many :expense_lists

    def total_claims
        self.expense_lists.sum(:fuel_claim) + self.expense_lists.sum(:toll_claim) +
        self.expense_lists.sum(:parking_claim) + self.expense_lists.sum(:allowance_claim) +
        self.expense_lists.sum(:medical_claim) + self.expense_lists.sum(:others_claim)
    end

end