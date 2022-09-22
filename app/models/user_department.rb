class UserDepartment < ApplicationRecord
  belongs_to :department
  has_many :users, dependent: :destroy
  has_many :reports, dependent: :destroy
end
