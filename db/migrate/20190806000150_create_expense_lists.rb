class CreateExpenseLists < ActiveRecord::Migration[5.2]
    def change
      create_table :expense_lists do |t|
        t.references :expense
        t.references :employee
        t.date :date
        t.float :fuel_claim
        t.float :toll_claim
        t.float :parking_claim
        t.float :allowance_claim
        t.float :medical_claim
        t.float :others_claim
        t.string :remarks
        t.timestamps
      end
    end
  end