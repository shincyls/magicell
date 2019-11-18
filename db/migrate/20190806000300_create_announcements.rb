class CreateAnnouncements < ActiveRecord::Migration[5.2]
    def change
      create_table :announcements do |t|
        t.references :users, default: 0
        t.string :announcement
        t.string :remarks
        t.date :start_date
        t.date :end_date
        t.boolean :show, default: false
        t.timestamps
      end
    end
  end