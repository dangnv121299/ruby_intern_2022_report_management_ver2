class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.integer :role, default: 1
      t.string :address
      t.string :password_digest
      t.boolean :activated, default: false
      t.string :reset_digest
      t.datetime :reset_send_at
      t.datetime :day_start

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
