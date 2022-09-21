class DailyReport < ApplicationRecord
  belongs_to :user
  belongs_to :department
  belongs_to :user_department

  enum status: {pending: 0, approved: 1, rejected: 2}
  validates :plan_today, :reality, :plan_next_day, :reason, presence: true,
            length: {maximum: Settings.daily_report.max_length}
end
