class CreateVariables < ActiveRecord::Migration[5.2]
    def change
      create_table :variables do |t|
        t.float :socso_perc
        t.float :epf_employer_perc
        t.float :epf_employee_perc
        t.float :eis_perc
        t.float :pcb_perc
      end
    end
  end