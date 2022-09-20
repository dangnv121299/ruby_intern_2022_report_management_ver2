class Department < ApplicationRecord
  has_many :user_departments, dependent: :nullify
  has_many :daily_reports, dependent: :destroy
  validates :name, presence: true,
      length: {maximum: Settings.department.max_name}
end
