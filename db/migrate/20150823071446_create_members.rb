class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :name
      t.string :address
      t.string :phone
      t.string :barcode

      t.timestamps null: false
    end
  end
end
