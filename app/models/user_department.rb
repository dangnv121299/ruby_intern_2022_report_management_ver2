class UserDepartment < ApplicationRecord
  belongs_to :department
  has_many :users, dependent: :destroy
  has_many :daily_reports, dependent: :destroy
end
