class Employee < ApplicationRecord

    belongs_to :department, optional: true
    belongs_to :company, optional: true
    belongs_to :project, optional: true
    has_one :user
    
    has_many :leaveaps
    has_many :timesheets
    has_many :timesheet_approvals

    enum position: ["Default","Standby","DTE","DTC","DTA","OSS","PM","Manager","Admin","HR","Finance","Consultant","IT","Intern"]
    enum employment_status: ["active","onleave","resigned","inactive","maternity","hospital","others"]
    
    def full_name
        self.last_name + ", " + self.first_name
    end

end
