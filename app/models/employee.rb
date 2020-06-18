class Employee < ApplicationRecord

    require 'csv'

    belongs_to :employee_position, optional: true
    belongs_to :company, optional: true
    belongs_to :project, optional: true
    belongs_to :department, optional: true
    has_many :leaveaps
    has_many :timesheet_tasks
    has_many :expense_lists
    has_one :user, dependent: :destroy

    validates :full_name, presence: {message: "must present."}
    # validates :identity_no, presence: {message: "must present."}, uniqueness: {message: "already exists!"}
    # validates :company_email, uniqueness: {case_sensitive: false, message: "already exists!"}, allow_blank: true, format: {with: /\b[A-Z0-9._%a-z\-]+@magicell.com.my/, message: "must valid format and magicell.com.my account." }
    # validates :company_email, presence: {message: "must present."}, uniqueness: {message: "already exists!"}, format: {with: /\b[A-Z0-9._%a-z\-]+@.+\..+/,
    #    message: "must valid email format." }
    # validates :personal_email, presence: {message: "must present."}, uniqueness: {message: "already exists!"}, format: {with: /\b[A-Z0-9._%a-z\-]+@.+\..+/, message: "must valid email format." }
    # validates :phone_number, presence: {message: "must present."}
    
    enum category: ["Permanent","Contract","Intern","ARP"]
    enum employment_status: ["Active","Archieved","Resigned","Maternity","Hidden","Others"]
    
    # scope :monthly_leave, ->(year, month) { joins(:leaveaps).where("DATE_PART('year', from_date) = ? and DATE_PART('month', from_date) = ? ", year, month)}
    
    def self.update_leaves(year)
        self.all.each do |e|
            e.annual_leave_taken = e.leaveaps.where("DATE_PART('year', from_date) = ? and leavetype_id = ? and status_leave_id = ?", year, 1, 4).sum("days")
            e.medical_leave_taken = e.leaveaps.where("DATE_PART('year', from_date) = ? and leavetype_id = ? and status_leave_id = ?", year, 2, 4).sum("days")
            e.save
        end
    end

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

    def whatsapp
        unless self.phone_number.blank?
            url = "https://api.whatsapp.com/send?phone=" + self.phone_number.gsub('-','').gsub('+','').gsub(' ','')
            return url
        else
            return ""
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

    def monthly_leave(year, month, status)
        if status == 1
            stend = 6
        else
            stend = status
        end
        self.leaveaps.where("DATE_PART('year', from_date) = ? and DATE_PART('month', from_date) = ? and status_leave_id >= ? and status_leave_id <= ?", year, month, status, stend).sum("days")
    end

    def monthly_timesheet(year, month, status)
        if status == 1
            stend = 6
        else
            stend = status
        end
        self.timesheet_tasks.where("DATE_PART('year', date) = ? and DATE_PART('month', date) = ? and status_timesheet_id >= ? and status_timesheet_id <= ?", year, month, status, stend).sum("working_hours")
    end

    def monthly_claim(year, month, status)
        if status == 1
            stend = 6
        else
            stend = status
        end
        self.expense_lists.where("DATE_PART('year', date) = ? and DATE_PART('month', date) = ? and status_expense_id >= ? and status_expense_id <= ?", year, month, status, stend).sum("fuel_claim + toll_claim + parking_claim + allowance_claim + medical_claim + others_claim")
    end

    def submitted_days(year, month)
        self.timesheet_tasks.where("DATE_PART('year', date) = ? and DATE_PART('month', date) = ?", year, month).distinct.count(:date)
    end

end
