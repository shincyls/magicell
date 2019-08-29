class CreateWebappContents < ActiveRecord::Migration[5.2]
  def change
    create_table :webapp_contents do |t|
      t.string :name
      t.float :value
      t.timestamps
    end
  end
end
