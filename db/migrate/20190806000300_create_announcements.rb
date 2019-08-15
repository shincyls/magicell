class CreateAnnouncements < ActiveRecord::Migration[5.2]
    def change
      create_table :announcements do |t|
        t.string :title
        t.string :remarks
        t.datetime :from
        t.datetime :until
        t.boolean :display, default: false
        t.timestamps
      end
    end
  end