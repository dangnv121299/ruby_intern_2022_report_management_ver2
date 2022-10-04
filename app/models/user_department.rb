class UserDepartment < ApplicationRecord
  UPDATABLE_ATTRS = [:name, :department_id, {user_ids: []}].freeze
  UPDATABLE_ATTRS_ADMIN = [:name, :role, :department_id, {user_ids: []}].freeze
  belongs_to :department
  belongs_to :user
  has_many :reports, dependent: :destroy

  enum role: {member: 0, manager: 1}

  scope :by_department, ->(department_id){where department_id: department_id}
  scope :by_user, ->(user_id){where user_id: user_id}
end
