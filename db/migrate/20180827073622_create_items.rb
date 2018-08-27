class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.references :scope, foreign_key: true
      t.string :category
      t.integer :quantity

      t.timestamps
    end
  end
end
