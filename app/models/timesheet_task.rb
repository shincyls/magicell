class TimesheetTask < ApplicationRecord

    attr_accessor :multi_date_from
    attr_accessor :multi_date_to
    attr_accessor :include_weekend

    belongs_to :timesheet
    belongs_to :employee

end