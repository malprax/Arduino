class CreateBillings < ActiveRecord::Migration
  def change
    create_table :billings do |t|
      t.string :user
      t.datetime :time_in
      t.datetime :time_out
      t.decimal :price
      t.string :comment

      t.timestamps null: false
    end
  end
end
