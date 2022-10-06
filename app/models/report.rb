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
  scope :search_status, ->(status){where(status: status) if status.present?}
  scope :search_department, lambda {|department_id|
                              if department_id.present?
                                where(department_id: department_id)
                              end
                            }
  scope :search_user, ->(user_id){where(user_id: user_id) if user_id.present?}
  scope :start, lambda {|start_date|
                  if start_date.present?
                    where "created_at > ?", start_date.to_date.beginning_of_day
                  end
                }
  scope :end, lambda {|end_date|
                if end_date.present?
                  where "created_at < ?", end_date.to_date.end_of_day
                end
              }

  enum status: {pending: 0, approved: 1, rejected: 2}
  validates :plan_today, :reality, :plan_next_day, presence: true,
            length: {maximum: Settings.report.max_length}

  delegate :name, to: :user, prefix: true

  class << self
    def search params
      search_status(params[:status])
        .start(params[:start_date])
        .end(params[:end_date])
        .search_department(params[:department_id])
        .search_user(params[:user_id])
    end
  end
end
