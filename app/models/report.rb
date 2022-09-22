class Report < ApplicationRecord
  belongs_to :user
  belongs_to :department, optional: true
  belongs_to :user_department, optional: true

  scope :newest, ->{order(created_at: :desc)}
  enum status: {pending: 0, approved: 1, rejected: 2}
  validates :plan_today, :reality, :plan_next_day, :reason, presence: true,
            length: {maximum: Settings.report.max_length}
  UPDATABLE_ATTRS = %i(plan_today reality reason plan_next_day).freeze

  delegate :name, to: :user, prefix: true
end
