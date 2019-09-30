class Project < ApplicationRecord

    belongs_to :company
    belongs_to :department
    belongs_to :manager, class_name: 'Employee', foreign_key: 'manager_id'
    has_many :employees
    has_many :timesheets

end