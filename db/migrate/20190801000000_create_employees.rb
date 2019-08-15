class CreateEmployees < ActiveRecord::Migration[5.2]
    def change
      create_table :employees do |t|
        t.string :first_name
        t.string :last_name
        t.string :employee_id
        t.string :title
        t.string :phone_number
        t.string :phone_number_2
        t.string :identity_number
        t.date :birthday
        t.float :base_salary, default: 0
        t.float :annual_leave_entitled, default: 12
        t.float :annual_leave_taken, default: 0
        t.float :medical_leave_entitled, default: 12
        t.float :medical_leave_taken, default: 0
        t.integer :position, default: 2
        t.integer :category, default: 0
        t.integer :employement_status, default: 0
        t.references :user
        t.references :department
        t.references :company
        t.references :project
        t.timestamps
      end
    end
  end