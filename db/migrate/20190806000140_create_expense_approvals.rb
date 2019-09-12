class CreateExpenseApprovals < ActiveRecord::Migration[5.2]
  def change
    create_table :expense_approvals do |t|
      t.references :expense
      t.references :employee
      t.references :manager
      t.boolean :approval, default: false
      t.boolean :reject, default: false
      t.string :reject_reason
      t.string :manager_remark
      t.timestamps
    end
  end
end