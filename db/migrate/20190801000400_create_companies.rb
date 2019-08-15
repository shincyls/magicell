class CreateCompanies < ActiveRecord::Migration[5.2]
    def change
      create_table :companies do |t|
        t.string :name
        t.string :address_1
        t.string :address_2
        t.string :contact_1
        t.string :contact_2
        t.string :description
        t.timestamps
      end
    end
  end