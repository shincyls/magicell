class CreateHolidays < ActiveRecord::Migration[5.2]
    def change
      create_table :holidays do |t|
        t.date :date
        t.string :remarks
        t.timestamps
      end
    end
  end