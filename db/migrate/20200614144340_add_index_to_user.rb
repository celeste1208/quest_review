class AddIndexToUser < ActiveRecord::Migration[5.2]
  def change
    add_index :users, [:email, :deleted_at], unique: true
  end
end
