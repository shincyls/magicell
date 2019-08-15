class CreateEaforms < ActiveRecord::Migration[5.2]
    def change
      create_table :eaforms do |t|
        t.references :employee
        t.integer :year
        t.float :base_salary, default: 0
        t.float :expenses_claim, default: 0
        t.float :others_claim, default: 0
        t.float :leave_deduction, default: 0
        t.float :socso, default: 0
        t.float :epf_employer, default: 0
        t.float :epf_employee, default: 0
        t.float :operator
        t.string :eaform_file
        t.timestamps
      end
    end
  end