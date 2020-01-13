class CreateWebappContents < ActiveRecord::Migration[5.2]
  def change
    create_table :webapp_contents do |t|
      t.string :name
      t.string :param
      t.float :value
      t.boolean :logic
      t.datetime :datetime
      t.timestamps
    end
  end
end
