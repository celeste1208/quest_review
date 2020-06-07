class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.references :user, foreign_key: true
      t.references :quest, foreign_key: true
      t.text :content, null: false
      t.string :type, null: false, index: true
      t.references :parent, foreign_key: { to_table: :comments }

      t.timestamps
    end
  end
end
