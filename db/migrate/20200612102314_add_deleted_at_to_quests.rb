class AddDeletedAtToQuests < ActiveRecord::Migration[5.2]
  def change
    add_column :quests, :deleted_at, :datetime
    add_index :quests, :deleted_at
  end
end
