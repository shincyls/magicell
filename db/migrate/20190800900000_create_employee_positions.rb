class CreateEmployeePositions < ActiveRecord::Migration[5.2]
  def change
    create_table :employee_positions do |t|
      t.string :position
      t.string :description
      t.timestamps
    end
  end
end