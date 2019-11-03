class Expense < ApplicationRecord

    belongs_to :employee
    has_many :expense_approvals
    has_many :expense_lists

    validates :year, presence: {message: "must presense."}
    validates :month, presence: {message: "must presense."}

    def total_claims
        self.expense_lists.sum(:fuel_claim) + self.expense_lists.sum(:toll_claim) +
        self.expense_lists.sum(:parking_claim) + self.expense_lists.sum(:allowance_claim) +
        self.expense_lists.sum(:medical_claim) + self.expense_lists.sum(:others_claim)
    end

    def session
        return self.year.to_s + "-" + ('%02d' % self.month)
    end

end