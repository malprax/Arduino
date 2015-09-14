class CreateAppraisals < ActiveRecord::Migration
  def change
    create_table :appraisals do |t|
      t.string :address
      t.integer :land_wide
      t.decimal :land_price
      t.integer :building_wide
      t.decimal :building_price
      t.date :appraisal
      t.string :comment

      t.timestamps null: false
    end
  end
end
