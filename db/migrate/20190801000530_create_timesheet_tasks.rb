class CreateTimesheetTasks < ActiveRecord::Migration[5.2]
    def change
        create_table :timesheet_tasks do |t|
          t.references :timesheet
          t.references :employee
          t.references :project
          t.string :activity
          t.string :site_name
          t.string :vehicle_number
          t.references :vehicle_owner
          t.references :project_region
          t.date :date
          t.integer :time_in, default: 9
          t.integer :time_out, default: 18
          t.integer :time_break, default: 1
          t.timestamps
        end
    end
end