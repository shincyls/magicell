class TimesheetTask < ApplicationRecord

    attr_accessor :multi_date_from
    attr_accessor :multi_date_to
    attr_accessor :exclude_weekend

    belongs_to :employee
    belongs_to :project
    belongs_to :vehicle_owner, optional: true
    belongs_to :project_region, optional: true
    belongs_to :status_timesheet

    validates :date, presence: {message: "must present."}
    validates :employee_id, presence: {message: "must present."}
    validates :project_id, presence: {message: "must present."}
    validates :activity, presence: {message: "must present."}

    def total_hours
        @sum = self.working_hours
        return @sum
    end

    def url
        self.attachment_link.replace("https://","").replace("http://","")
    end

    def holiday?
        self.date.saturday? or self.date.sunday? or Holiday.list.include?(self.date.strftime("%F"))
    end

end