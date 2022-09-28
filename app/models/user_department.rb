class UserDepartment < ApplicationRecord
  UPDATABLE_ATTRS = [:name, :department_id, {user_ids: []}].freeze

  belongs_to :department
  belongs_to :user
  has_many :reports, dependent: :destroy
  scope :by_id, ->(department_id){where department_id: department_id}
end
