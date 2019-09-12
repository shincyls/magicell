class CreateTimesheets < ActiveRecord::Migration[5.2]
    def change
        create_table :timesheets do |t|
          t.references :employee
          t.references :timesheet_category
          t.references :project
          t.string :session
          t.integer :year
          t.integer :month
          t.boolean :submitted, default: false
          t.timestamps
        end
    end
end