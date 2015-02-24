class CreatePaypals < ActiveRecord::Migration
  def change
    create_table :paypals do |t|
      t.string :name
      t.string :cardno
      t.date :expdate
      t.integer :cvv_no
      t.timestamps
    end
  end
end
