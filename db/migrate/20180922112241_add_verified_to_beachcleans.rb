class AddVerifiedToBeachcleans < ActiveRecord::Migration[5.2]
  def change
    add_column :beachcleans, :verified, :boolean
  end
end
