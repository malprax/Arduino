class CreateParks < ActiveRecord::Migration
  def change
    create_table :parks do |t|
      t.string :number
      t.string :billing_id

      t.timestamps null: false
    end
  end
end
