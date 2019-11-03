class Timesheet < ApplicationRecord

    belongs_to :employee
    has_many :timesheet_approvals
    has_many :timesheet_tasks

    validates :year, presence: {message: "must presense."}
    validates :month, presence: {message: "must presense."}


    def total_hours
        self.timesheet_tasks.sum(:time_out) - self.timesheet_tasks.sum(:time_in) - self.timesheet_tasks.sum(:time_break)
    end

    def total_wages
        @sum = self.timesheet_tasks.sum(:time_out) - self.timesheet_tasks.sum(:time_in) - self.timesheet_tasks.sum(:time_break)
        @sum = @sum*30
        return @sum
    end

    def session
     return self.year.to_s + "-" + ('%02d' % self.month)
    end

end