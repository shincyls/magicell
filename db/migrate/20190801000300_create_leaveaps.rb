class CreateLeaveaps< ActiveRecord::Migration[5.2]
    def change
      create_table :leaveaps do |t|
        t.references :employee
        t.references :leavetype, default: 1
        t.string :reason
        t.string :contact_person
        t.string :contact_number
        t.date :from_date
        t.string :from_ampm, default: "AM"
        t.date :to_date
        t.string :to_ampm, default: "PM"
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