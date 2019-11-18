class CreateDepartments < ActiveRecord::Migration[5.2]
    def change
      create_table :departments do |t|
        t.references :company
        t.string :name
        t.string :description
        t.string :address
        t.string :phone
        t.timestamps
      end
    end
  end