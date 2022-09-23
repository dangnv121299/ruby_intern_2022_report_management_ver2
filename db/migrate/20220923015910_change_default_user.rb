class ChangeDefaultUser < ActiveRecord::Migration[6.1]
  def change
    change_column_default :users, :role, from: 1, to: 0
    change_column :users, :day_start, :date
    remove_reference :user_departments, :user, index: true, foreign_key: true

    add_reference :users, :user_department, index: true, foreign_key: true
  end
end
