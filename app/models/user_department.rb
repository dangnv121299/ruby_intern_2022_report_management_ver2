class UserDepartment < ApplicationRecord
  UPDATABLE_ATTRS = %i(name department_id user_id).freeze

  belongs_to :department
  belongs_to :user
  has_many :reports, dependent: :destroy
end
