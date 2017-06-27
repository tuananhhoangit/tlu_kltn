class DeviseCreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email, null: false, default: ""
      t.boolean :is_admin
      t.string :encrypted_password, null: false, default: ""
      t.string :remember_digest

      t.timestamps null: false
    end
    add_index :users, :email, unique: true
  end
end
