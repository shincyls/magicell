class TimesheetTask < ApplicationRecord

    attr_accessor :multi_date_from
    attr_accessor :multi_date_to
    attr_accessor :include_weekend

    belongs_to :timesheet
    belongs_to :employee
    belongs_to :project
    belongs_to :vehicle_owner, optional: true
    belongs_to :project_region, optional: true

    def total_hours
        @sum = self.time_out - self.time_in - self.time_break
        return @sum
    end

    def total_wages
        @sum = (self.time_out - self.time_in - self.time_break)*30
        return @sum
    end

end