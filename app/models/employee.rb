class Employee < ApplicationRecord

    belongs_to :user
    belongs_to :department
    belongs_to :company
    belongs_to :project
    
    has_many :leaveaps
    has_many :timesheets

    enum position: ["Default","Standby","DTE","DTC","DTA","OSS","PM","Manager","Admin","HR","Finance","Consultant","IT","Intern"]
    enum employment_status: ["active","onleave","resigned","inactive","maternity","hospital","others"]

end
