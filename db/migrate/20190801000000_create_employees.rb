class CreateEmployees < ActiveRecord::Migration[5.2]
    def change
      create_table :employees do |t|
        t.references :department, default: 1
        t.references :project, default: 1
        t.references :company, default: 1
        t.references :employee_position, default: 1
        t.string :full_name
        t.string :gender
        t.string :personal_email
        t.string :company_email
        t.string :employee_code
        t.string :job_title
        t.string :phone_number
        t.string :phone_number_emergency
        t.string :address
        t.string :address_2
        t.string :nationality
        t.string :race
        t.string :identity_no
        t.string :bank_name
        t.string :bank_account
        t.string :epf_account
        t.string :lhdn_account
        t.string :medical_account
        t.string :insurance_account
        t.string :marital_status
        t.string :spouse_name
        t.integer :children_count
        t.date :birthday
        t.date :joined_since
        t.date :joined_last
        t.float :base_salary, default: 0
        t.float :fix_allowance, default: 0
        t.float :annual_leave_entitled, default: 12
        t.float :annual_leave_taken, default: 0
        t.float :medical_leave_entitled, default: 12
        t.float :medical_leave_taken, default: 0
        t.date :contract_start
        t.date :contract_end
        t.integer :category, default: 0
        t.integer :employment_status, default: 0
        t.timestamps
      end
    end
  end