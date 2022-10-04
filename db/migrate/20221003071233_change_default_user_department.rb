class ChangeDefaultUserDepartment < ActiveRecord::Migration[6.1]
  def change
    change_column_default :user_departments, :role, from: 1, to: 0
  end
end
