class CreateObservations < ActiveRecord::Migration[5.2]
  def change
    create_table :observations do |t|
      t.references :scope, foreign_key: true
      t.string :species
      t.string :behaviour

      t.timestamps
    end
  end
end
