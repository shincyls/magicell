class CreateTimesheets < ActiveRecord::Migration[5.2]
    def change
        create_table :timesheets do |t|
          t.references :employee
          t.string :task
          t.string :contact
          t.date :date
          t.string :slot_1
          t.string :slot_2
          t.string :slot_3
          t.string :slot_4
          t.string :slot_5
          t.string :slot_6
          t.string :slot_7
          t.string :slot_8
          t.string :slot_9
          t.string :slot_10
          t.boolean :confirm, default: false
          t.boolean :approved_1, default: false
          t.string :reject_1
          t.boolean :approved_2, default: false
          t.string :reject_2
          t.boolean :approved_3, default: false
          t.string :reject_3
          t.timestamps
        end
      end
    end