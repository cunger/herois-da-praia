class RenameItemTypeToCategory < ActiveRecord::Migration[5.2]
  def change
    rename_column :items, :type, :category
  end
end
