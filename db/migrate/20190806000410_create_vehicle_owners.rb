class CreateVehicleOwners < ActiveRecord::Migration[5.2]
    def change
      create_table :vehicle_owners do |t|
        t.string :name
        t.timestamps
      end
    end
  end