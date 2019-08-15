class Employee < ApplicationRecord

    belongs_to :user
    belongs_to :department
    belongs_to :company
    belongs_to :project

    has_many :leaveaps
    has_many :timesheets

    enum position: ["staff", "hr", "project", "manager", "director"]
    enum employment_status: ["active","resigned","inactive","maternity","hospital","others"]

end
