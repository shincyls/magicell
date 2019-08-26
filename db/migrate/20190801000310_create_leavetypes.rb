class CreateLeavetypes < ActiveRecord::Migration[5.2]
    def change
      create_table :leavetypes do |t|
        t.string :name
        t.string :description
        t.integer :days, default: 0
        t.timestamps
      end
    end
  end