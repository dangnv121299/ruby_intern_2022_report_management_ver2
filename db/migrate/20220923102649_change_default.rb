class ChangeDefault < ActiveRecord::Migration[6.1]
  def change
    add_reference :user_departments, :user, index: true, foreign_key: true

    remove_reference :users, :user_department, index: true, foreign_key: true
  end
end
