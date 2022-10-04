class Department < ApplicationRecord
  UPDATABLE_ATTRS = %i(name).freeze

  has_many :user_departments, dependent: :nullify
  has_many :reports, dependent: :destroy
  has_many :users, through: :user_departments
  validates :name, presence: true,
      length: {maximum: Settings.department.max_name}

  scope :by_id, ->(department_id){where id: department_id}
end
