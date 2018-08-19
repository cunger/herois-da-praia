class CreateCleanups < ActiveRecord::Migration[5.2]
  def change
    create_table :cleanups do |t|
      t.references :user, foreign_key: true
      t.string :place
      t.date :date

      t.timestamps
    end
  end
end
