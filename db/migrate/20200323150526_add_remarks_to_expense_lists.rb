class AddRemarksToExpenseLists < ActiveRecord::Migration[5.2]
  def change
    add_column :expense_lists, :remarks, :string
    add_column :expense_lists, :approved_by, :string
    add_column :expense_lists, :approved_at, :datetime
    add_column :timesheet_tasks, :approved_by, :string
    add_column :timesheet_tasks, :approved_at, :datetime
  end
end