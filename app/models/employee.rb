class Employee < ApplicationRecord

    belongs_to :department, optional: true
    belongs_to :company, optional: true
    belongs_to :project, optional: true
    has_one :user, dependent: :destroy
    has_many :leaveaps
    has_many :timesheets
    has_many :timesheet_approvals

    validates :full_name, presence: {message: "must present."}
    validates :identity_passport_no, presence: {message: "must present."}, uniqueness: {message: "already exists!"}
    validates :company_email, uniqueness: {message: "already exists!"}, format: {with: /\b[A-Z0-9._%a-z\-]+@magicell.com.my/,
        message: "must valid format and magicell.com.my account" }
    validates :personal_email, presence: {message: "must present."}, uniqueness: {message: "already exists!"}, format: {with: /\b[A-Z0-9._%a-z\-]+@.+\..+/,
        message: "must valid format and magicell.com.my account" }
    validates :phone_number, presence: {message: "must present."}
    # validates :first_name, presence: {message: "must present."}
    # validates :last_name, presence: {message: "must present."}
    # validates :address, presence: {message: "must present."}

    enum category: ["permanent","contract"]
    enum employment_status: ["active","onleave","resigned","inactive","maternity","hospital","others"]
    
    def combine_name
        self.last_name + ", " + self.first_name
    end

end
