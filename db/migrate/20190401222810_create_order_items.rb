class CreateOrderItems < ActiveRecord::Migration[5.1]
  def change
    create_table :order_items do |t|
      t.boolean :fulfilled, default: false
      t.integer :quantity
      t.float :order_price, scale: 2
      t.references :order, foreign_key: true
      t.references :item, foreign_key: true
      t.timestamps
    end
  end
end
