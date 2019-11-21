class CreateProjects < ActiveRecord::Migration[5.2]
    def change
      create_table :projects do |t|
        t.string :name
        t.string :description
        t.string :vendor
        t.string :operator
        t.date :start_date
        t.date :end_date
        t.references :company
        t.references :department
        t.references :manager
        t.references :manager_alt
        t.references :project_client, default: 1
        t.boolean :site?, default: false
        t.boolean :vehicle?, default: false
        t.integer :project_status, default: 0
        t.timestamps
      end
    end
  end