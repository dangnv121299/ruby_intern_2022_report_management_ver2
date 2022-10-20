class ChangeUniqueNameDepartment < ActiveRecord::Migration[6.1]
  def change
    add_index :departments, :name, unique: true
  end
end
