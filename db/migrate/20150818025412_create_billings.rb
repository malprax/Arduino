class CreateBillings < ActiveRecord::Migration
  def change
    create_table :billings do |t|
      t.integer :member_id
      t.datetime :time_in
      t.datetime :time_out
      t.datetime :duration
      t.decimal :price
      t.string :comment
      t.date :expiration
      t.integer :number_park
      t.timestamps null: false
    end
  end
end
