class CreateEmployeeContracts < ActiveRecord::Migration[5.2]
    def change
      create_table :employee_contracts do |t|
        t.references :employee
        t.references :project
        t.date :start_from
        t.date :end_at
        t.float :base_salary
        t.timestamps
      end
    end
  end