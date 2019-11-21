class CreateTimesheetTasks < ActiveRecord::Migration[5.2]
    def change
        create_table :timesheet_tasks do |t|
          t.references :employee
          t.references :project
          t.references :timesheet_category, default: 1
          t.references :status_timesheet, default: 1
          t.references :vehicle_owner
          t.references :project_region
          t.date :date
          t.string :activity
          t.string :site_name, limit: 6
          t.string :vehicle_number, limit: 8
          t.integer :working_hours, default: 8
          t.string :attachment_link
          t.datetime :submitted_at
          t.timestamps
        end
    end
end