class AddSubmittedToCleanups < ActiveRecord::Migration[5.2]
  def change
    add_column :cleanups, :submitted, :boolean
    change_column_null :cleanups, :submitted, false
    change_column_default :cleanups, :submitted, false
  end
end
