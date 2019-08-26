class Project < ApplicationRecord

    belongs_to :company
    belongs_to :department
    has_many :employees
    has_many :timesheets

end