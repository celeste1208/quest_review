class CreateQuests < ActiveRecord::Migration[5.2]
  def change
    create_table :quests do |t|
      t.integer :develop_id, null:false, unique: true
      t.string :title,       null:false
      t.text   :content
      t.string :responsible, null:false

      t.timestamps
    end
  end
end
