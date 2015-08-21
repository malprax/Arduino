class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :address
      t.string :phone
      t.string :rqr_code

      t.timestamps null: false
    end
  end
end
