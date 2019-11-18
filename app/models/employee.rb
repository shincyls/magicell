class Employee < ApplicationRecord

    require 'csv'

    belongs_to :employee_position, optional: true
    belongs_to :company, optional: true
    belongs_to :project, optional: true
    belongs_to :department, optional: true
    has_many :leaveaps
    has_many :timesheets
    has_many :timesheet_tasks
    has_many :emp_timesheet_approvals, class_name: 'TimesheetApproval', foreign_key: 'employee_id'
    has_many :mgr_timesheet_approvals, class_name: 'TimesheetApproval', foreign_key: 'manager_id'
    has_many :expenses
    has_many :expense_lists
    has_many :emp_expense_approvals, class_name: 'TimesheetApproval', foreign_key: 'employee_id'
    has_many :mgr_expense_approvals, class_name: 'TimesheetApproval', foreign_key: 'manager_id'
    has_one :user, dependent: :destroy

    validates :full_name, presence: {message: "must present."}
    # validates :identity_no, presence: {message: "must present."}, uniqueness: {message: "already exists!"}
    # validates :company_email, uniqueness: {case_sensitive: false, message: "already exists!"}, allow_blank: true, format: {with: /\b[A-Z0-9._%a-z\-]+@magicell.com.my/, message: "must valid format and magicell.com.my account." }
    validates :company_email, presence: {message: "must present."}, uniqueness: {message: "already exists!"}, format: {with: /\b[A-Z0-9._%a-z\-]+@.+\..+/,
        message: "must valid email format." }
    validates :personal_email, presence: {message: "must present."}, uniqueness: {message: "already exists!"}, format: {with: /\b[A-Z0-9._%a-z\-]+@.+\..+/,
        message: "must valid email format." }
    # validates :phone_number, presence: {message: "must present."}
    

    enum category: ["Permanent","Contract","Intern"]
    enum employment_status: ["Active","Archieved","Resigned","Maternity","Hospital","Others"]
    
    def combine_name
        self.last_name + ", " + self.first_name
    end

    def self.import(file)
        CSV.foreach(file.path, headers: true) do |row|
            params = row.to_hash
            # Data Adjustment to Fit into Database
            params['category'] = params['category'].to_i
            params['employment_status'] = params['employment_status'].to_i
            params['full_name'] = params['full_name'].titleize
            # Importing Data Here
            unless Employee.exists?(full_name: params['full_name'])
                Employee.new(params).save
            else
                params.reject{|_, v| v.blank?}
                @employee = Employee.find_by(full_name: params['full_name'])
                @employee.update(params)
            end
        end
    end
    
    def annual_days(approve)
        @leveaps = self.leaveaps.where(leavetype_id: 1, apv_1: approve)
        @total = 0
        @leveaps.each do |l|
            @total += l.total_days
        end 
        return @total
    end

    def medical_days(approve)
        @leveaps = self.leaveaps.where(leavetype_id: 2, apv_1: approve)
        @total = 0
        @leveaps.each do |l|
            @total += l.total_days
        end 
        return @total
    end

    def avail_email
        if self.company_email
            return self.company_email
        elsif self.company_email
            return self.personal_email
        end
    end

end
