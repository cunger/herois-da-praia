class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :group
      t.string :email
      t.string :encrypted_password
      t.string :salt

      t.timestamps
    end
  end
end
