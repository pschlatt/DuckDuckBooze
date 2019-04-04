class ChangeDefaultUserValue < ActiveRecord::Migration[5.1]
  def change
    change_column_default :users, :role, 1
  end
end
