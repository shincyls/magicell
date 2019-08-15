class CreateProjects < ActiveRecord::Migration[5.2]
    def change
      create_table :projects do |t|
        t.string :name
        t.string :description
        t.string :vendor
        t.string :operator
        t.references :company
        t.references :department
        t.timestamps
      end
    end
  end