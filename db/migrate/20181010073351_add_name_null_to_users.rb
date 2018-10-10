class AddNameNullToUsers < ActiveRecord::Migration[5.1]
  def change
    change_column_null :users, :name, :string, null: false
  end
end
