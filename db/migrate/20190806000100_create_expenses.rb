class CreateExpenses < ActiveRecord::Migration[5.2]
    def change
      create_table :expenses do |t|
        t.references :employee
        t.string :session
        t.integer :year
        t.integer :month
        t.boolean :submitted, default: false
        t.timestamps
      end
    end
  end