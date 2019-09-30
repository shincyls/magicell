class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.string :remember_digest
      t.references :webrole, default: 2
      t.references :employee
      t.string :password_reset_token
      t.datetime :password_reset_sent_at
      t.timestamps
    end
  end
end
