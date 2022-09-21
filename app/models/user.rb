class User < ApplicationRecord
  belongs_to :user_department, optional: true
  has_many :daily_reports, dependent: :destroy

  has_secure_password
  validates :password, presence: true,
             length: {minimum: Settings.user.min_password}, allow_nil: true

  validates :name, presence: true, length: {maximum: Settings.user.max_name}

  validates :email, presence: true, length: {maximum: Settings.user.max_email},
                    format: {with: Settings.user.email_regex},
                    uniqueness: true
  UPDATABLE_ATTRS = %i(name email password password_confirmation).freeze

  class << self
    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create(string, cost: cost)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end
end
