class Project < ApplicationRecord

    belongs_to :company
    belongs_to :department
    belongs_to :project_client
    belongs_to :manager, class_name: 'Employee', foreign_key: 'manager_id'
    belongs_to :manager_alt, class_name: 'Employee', foreign_key: 'manager_alt_id', optional: true
    has_many :employees
    has_many :timesheet_tasks
    has_many :expense_lists

    enum project_status: ["Active","Archieved","Others"]

    def total_claims
    end

    def total_timesheets
    end

end