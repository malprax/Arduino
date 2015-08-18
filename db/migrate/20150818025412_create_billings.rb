class CreateBillings < ActiveRecord::Migration
  def change
    create_table :billings do |t|
      t.string :user
      t.time :time_in
      t.time :time_out
      t.time :duration
      t.decimal :price

      t.timestamps null: false
    end
  end
end
