class User < ApplicationRecord
  UPDATABLE_ATTRS_MANAGER = %i(name email password password_confirmation phone
                               address day_start).freeze
  UPDATABLE_ATTRS = %i(name email password password_confirmation phone
                       address).freeze

  has_many :user_departments, dependent: :destroy
  has_many :reports, dependent: :destroy
  has_many :departments, through: :user_departments

  accepts_nested_attributes_for :user_departments

  has_secure_password
  validates :password, presence: true,
             length: {minimum: Settings.user.min_password}, allow_nil: true

  validates :name, presence: true, length: {maximum: Settings.user.max_name}

  validates :email, presence: true, length: {maximum: Settings.user.max_email},
                    format: {with: Settings.user.email_regex},
                    uniqueness: true

  enum role: {member: 0, manager: 1, admin: 2}

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

  def feed
    Report.newest.by_department_id departments.pluck(:id)
  end
end
