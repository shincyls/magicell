class CreateEmployees < ActiveRecord::Migration[5.2]
    def change
      create_table :employees do |t|
        t.references :department, default: 1
        t.references :project, default: 1
        t.references :company, default: 1
        t.references :employee_position, default: 1
        t.string :first_name
        t.string :last_name
        t.string :full_name
        t.string :personal_email
        t.string :company_email
        t.string :employee_id
        t.string :title
        t.string :phone_number
        t.string :phone_number_2
        t.string :address
        t.string :address_2
        t.string :nationality
        t.string :race
        t.string :identity_passport_no
        t.string :marital_status
        t.string :spouse_name
        t.string :bank_name
        t.string :bank_account
        t.integer :children_count
        t.date :birthday
        t.date :joined_since
        t.date :joined_last
        t.float :base_salary, default: 0
        t.float :annual_leave_entitled, default: 12
        t.float :annual_leave_taken, default: 0
        t.float :medical_leave_entitled, default: 12
        t.float :medical_leave_taken, default: 0
        t.date :contract_start
        t.date :contract_end
        t.integer :category, default: 0
        t.integer :employement_status, default: 0
        t.timestamps
      end
    end
  end