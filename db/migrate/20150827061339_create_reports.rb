class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.datetime :date
      t.integer :billing_id
      t.integer :member_id
      t.datetime :time_in
      t.datetime :time_out
      t.datetime :duration
      t.string :comment
      t.decimal :price
      t.timestamps null: false
    end
  end
end
