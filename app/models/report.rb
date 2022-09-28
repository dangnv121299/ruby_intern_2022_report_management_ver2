class Report < ApplicationRecord
  UPDATABLE_ATTRS = %i(plan_today reality reason plan_next_day
                       department_id).freeze
  UPDATABLE_ATTRS_MANAGER = %i(status comment user_department_id).freeze

  belongs_to :user
  belongs_to :department, optional: true
  belongs_to :user_department, optional: true

  scope :newest, ->{order(created_at: :desc)}
  scope :by_id, ->(id){where(id: id)}
  scope :by_user_id, ->(user_id){where(user_id: user_id)}
  scope :by_department_id, lambda {|department_id|
                             where(department_id: department_id)
                           }
  enum status: {pending: 0, approved: 1, rejected: 2}
  validates :plan_today, :reality, :plan_next_day, :reason, presence: true,
            length: {maximum: Settings.report.max_length}

  delegate :name, to: :user, prefix: true
end
