class Timesheet < ApplicationRecord

    belongs_to :employee
    belongs_to :project
    belongs_to :timesheet_category
    has_many :timesheet_approvals
    has_many :timesheet_tasks

end