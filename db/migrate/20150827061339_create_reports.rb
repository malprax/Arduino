class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.date :date
      t.integer :billing_id
      t.integer :member_id
      t.datetime :time_in
      t.datetime :time_out
      t.datetime :duration
      t.string :comment
      t.decimal :price
     
      # t.integer :member_id
#       t.datetime :time_in
#       t.datetime :time_out
#       t.decimal :price
#       t.string :comment
#       t.datetime :expiration
      t.timestamps null: false
    end
  end
end
