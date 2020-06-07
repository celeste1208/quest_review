class RenameTypeColumnToComments < ActiveRecord::Migration[5.2]
  def change
    rename_column :comments, :type, :opinion_type
  end
end
