class CreateLeaveaps< ActiveRecord::Migration[5.2]
    def change
      create_table :leaveaps do |t|
        t.references :employee
        t.string :leave_type
        t.string :reason
        t.string :contact_person
        t.string :contact_number
        t.date :from_date
        t.integer :from_ampm, default: 0
        t.date :to_date
        t.integer :to_ampm, default: 0
        t.string :total_days
        t.boolean :confirm, default: false
        t.boolean :approved_1, default: false
        t.string :reject_reason_1
        t.boolean :approved_2, default: false
        t.string :reject_reason_2
        t.boolean :approved_3, default: false
        t.string :reject_reason_3
        t.timestamps
      end
    end
  end