class AddNameDefaultToUsers < ActiveRecord::Migration[5.1]
  def change
    change_column_default :users, :name, :string, default:''
  end
end
