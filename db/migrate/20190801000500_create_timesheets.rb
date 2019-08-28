class CreateTimesheets < ActiveRecord::Migration[5.2]
    def change
        create_table :timesheets do |t|
          t.references :employee
          t.references :timesheet_category
          t.references :timesheet_approval
          t.references :project
          t.string :site_name
          t.string :location
          t.date :date, default: "2019-08-01"
          t.integer :time_in, default: 9
          t.integer :time_out, default: 18
          t.integer :time_break, default: 1
          t.timestamps
        end
    end
end