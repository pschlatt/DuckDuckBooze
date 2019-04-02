class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.integer :role, default: 0
      t.boolean :enabled, default: false 
      t.string :name
      t.string :street
      t.string :city
      t.string :state
      t.string :zip
      t.string :email
      t.string :password_digest
      t.timestamps
    end
  end
end
