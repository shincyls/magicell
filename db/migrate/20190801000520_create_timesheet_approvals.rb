class CreateTimesheetApprovals < ActiveRecord::Migration[5.2]
  def change
    create_table :timesheet_approvals do |t|
      t.references :employee
      t.integer :month
      t.references :apv_mgr_1
      t.references :apv_mgr_2
      t.references :apv_mgr_3
      t.boolean :apv_1, default: false
      t.boolean :apv_2, default: false
      t.boolean :apv_3, default: false
      t.string :apv_reject_1
      t.string :apv_reject_2
      t.string :apv_reject_3
      t.timestamps
    end
  end
end