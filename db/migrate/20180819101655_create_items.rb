class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.references :cleanup, foreign_key: true
      t.string :type
      t.integer :quantity

      t.timestamps
    end
  end
end
