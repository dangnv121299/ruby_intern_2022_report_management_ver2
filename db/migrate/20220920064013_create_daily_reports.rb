class CreateDailyReports < ActiveRecord::Migration[6.1]
  def change
    create_table :daily_reports do |t|
      t.column :status, :integer, default: 0
      t.text :plan_today
      t.text :reality
      t.text :reason
      t.text :plan_next_day
      t.references :users, null: false, foreign_key: true
      t.references :user_departments, null: false, foreign_key: true
      t.references :departments, null: false, foreign_key: true

      t.timestamps
    end
  end
end
