class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.datetime :date
      t.string :member
      t.string :time_in
      t.string :time_out
      t.string :duration
      t.decimal :price

      t.timestamps null: false
    end
  end
end
