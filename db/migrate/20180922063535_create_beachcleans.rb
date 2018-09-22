class CreateBeachcleans < ActiveRecord::Migration[5.2]
  def change
    create_table :beachcleans do |t|
      t.string     :uuid
      t.date       :date
      t.references :place, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
