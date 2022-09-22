class ChangeUsersFromReport < ActiveRecord::Migration[6.1]
  def change
    remove_reference :reports, :users, index: true, foreign_key: true
    add_reference :reports, :user, index: true, foreign_key: true

    remove_reference :reports, :user_departments, index: true, foreign_key: true
    add_reference :reports, :user_department, index: true, foreign_key: true

    remove_reference :reports, :departments, index: true, foreign_key: true
    add_reference :reports, :department, index: true, foreign_key: true

    remove_reference :user_departments, :departments, index: true, foreign_key: true
    add_reference :user_departments, :department, index: true, foreign_key: true

    remove_reference :user_departments, :users, index: true, foreign_key: true
    add_reference :user_departments, :user, index: true, foreign_key: true
  end
end
