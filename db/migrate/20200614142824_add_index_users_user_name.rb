class AddIndexUsersUserName < ActiveRecord::Migration[5.2]
  def change
    add_index :users, [:user_name, :deleted_at], unique: true
  end
end
