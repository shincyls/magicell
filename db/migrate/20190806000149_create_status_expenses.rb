class CreateStatusExpenses < ActiveRecord::Migration[5.2]
  def change
    create_table :status_expenses do |t|
      t.string :name
      t.string :description
      t.string :css, default: "info"
      t.timestamps
    end
  end
end