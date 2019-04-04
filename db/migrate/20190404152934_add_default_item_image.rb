class AddDefaultItemImage < ActiveRecord::Migration[5.1]
  def change
    change_column_default :items, :image, "https://cdn.shopify.com/s/files/1/1143/3886/products/beer-stout_bca770f6-881f-4a8f-99b7-dc2f607edf84_1024x1024.jpg?v=1522432087"
  end
end
