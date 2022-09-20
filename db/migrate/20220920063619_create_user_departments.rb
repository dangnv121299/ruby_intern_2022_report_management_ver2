class CreateUserDepartments < ActiveRecord::Migration[6.1]
  def change
    create_table :user_departments do |t|
      t.string :name
      t.datetime :day_start
      t.integer :role, default: 1
      t.references :departments, null: false, foreign_key: true
      t.references :users, null: false, foreign_key: true

      t.timestamps
    end
  end
end
