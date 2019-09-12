class ExpenseList < ApplicationRecord

    attr_accessor :multi_date_from
    attr_accessor :multi_date_to
    attr_accessor :include_weekend

    belongs_to :expense
    belongs_to :employee

end