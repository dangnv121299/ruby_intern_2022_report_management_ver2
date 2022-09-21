class User < ApplicationRecord
  belongs_to :user_department
  has_many :daily_reports, dependent: :destroy

  has_secure_password
  validates :password, presence: true,
             length: {minimum: Settings.user.min_password}, allow_nil: true

  validates :name, presence: true, length: {maximum: Settings.user.max_name}

  validates :email, presence: true, length: {maximum: Settings.user.max_email},
                    format: {with: Settings.user.email_regex},
                    uniqueness: true
end
