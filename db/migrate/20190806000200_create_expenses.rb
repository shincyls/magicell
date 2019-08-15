class CreateExpenses < ActiveRecord::Migration[5.2]
    def change
      create_table :expenses do |t|
        t.references :employee
        t.integer :month
        t.float :month_salary
        t.float :expenses_claim, default: 0
        t.float :others_claim, default: 0
        t.float :leave_deduction, default: 0
        t.float :socso, default: 0
        t.float :epf_employer, default: 0
        t.float :epf_employee, default: 0
        t.float :operator
        t.timestamps
      end
    end
  end