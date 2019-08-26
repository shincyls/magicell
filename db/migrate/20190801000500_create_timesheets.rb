class CreateTimesheets < ActiveRecord::Migration[5.2]
    def change
        create_table :timesheets do |t|
          t.references :employee
          t.references :timesheet_category
          t.references :project
          t.string :site_name
          t.string :location
          t.date :date, default: "2019-08-01"
          t.integer :time_in, default: 9
          t.integer :time_out, default: 18
          t.integer :time_break, default: 1
          t.boolean :app_confirm, default: false
          t.boolean :apv_1, default: false
          t.references :apv_mgr_1
          t.string :apv_reject_1
          t.references :apv_mgr_2
          t.boolean :apv_2, default: false
          t.string :apv_reject_2
          t.references :apv_mgr_3
          t.boolean :apv_3, default: false
          t.string :apv_reject_3
          t.timestamps
        end
    end
end