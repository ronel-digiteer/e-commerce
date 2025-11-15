class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.text :address, null: false
      t.decimal :total_price, precision: 10, scale: 2

      t.timestamps
    end
  end
end