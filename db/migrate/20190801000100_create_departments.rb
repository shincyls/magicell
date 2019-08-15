class CreateDepartments < ActiveRecord::Migration[5.2]
    def change
      create_table :departments do |t|
        t.string :name
        t.string :description
        t.string :info_1
        t.string :info_2
        t.references :company
        t.timestamps
      end
    end
  end