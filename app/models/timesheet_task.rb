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

    validates :fuel_claim, numericality: {only_float: true, message: "must be float number."}
    validates :toll_claim, numericality: {only_float: true, message: "must be float number."}
    validates :parking_claim, numericality: {only_float: true, message: "must be float number."}
    validates :allowance_claim, numericality: {only_float: true, message: "must be float number."}
    validates :medical_claim, numericality: {only_float: true, message: "must be float number."}
    validates :others_claim, numericality: {only_float: true, message: "must be float number."}
    validates :odometer_reading, numericality: {only_float: true, message: "must be float number."}

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

    def allowed_edit?
        [1,2,3,4,5].include?(self.status_timesheet_id)
    end

end