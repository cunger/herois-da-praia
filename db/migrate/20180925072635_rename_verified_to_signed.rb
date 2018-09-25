class RenameVerifiedToSigned < ActiveRecord::Migration[5.2]
  def change
    rename_column :beachcleans, :verified, :signed
  end
end
