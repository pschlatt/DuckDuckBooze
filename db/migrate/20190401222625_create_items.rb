class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.boolean :enabled, default: true
      t.string :name
      t.string :image
      t.text :description
      t.integer :stock
      t.float :item_price, scale: 2
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
