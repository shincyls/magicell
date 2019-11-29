class CreateExpenseLists < ActiveRecord::Migration[5.2]
    def change
      create_table :expense_lists do |t|
        t.references :employee
        t.references :project
        t.references :status_expense, default: 1
        t.date :date
        t.float :fuel_claim, default: 0
        t.float :toll_claim, default: 0
        t.float :parking_claim, default: 0
        t.float :allowance_claim, default: 0
        t.float :medical_claim, default: 0
        t.float :others_claim, default: 0
        t.integer :odometer_reading, default: 0
        t.integer :holiday, default: 0
        t.string :attachment_link
        t.datetime :submitted_at
        t.timestamps
      end
    end
  end