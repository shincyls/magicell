class Timesheet < ApplicationRecord

    belongs_to :employee
    has_many :timesheet_approvals
    has_many :timesheet_tasks

    def total_hours
        self.timesheet_tasks.sum(:time_out) - self.timesheet_tasks.sum(:time_in) - self.timesheet_tasks.sum(:time_break)
    end

    def total_wages
        @sum = self.timesheet_tasks.sum(:time_out) - self.timesheet_tasks.sum(:time_in) - self.timesheet_tasks.sum(:time_break)
        @sum = @sum*30
        return @sum
    end

end