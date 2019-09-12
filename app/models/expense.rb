class Expense < ApplicationRecord

    belongs_to :employee
    has_many :expense_approvals
    has_many :expense_lists

end