class User < ApplicationRecord
  has_secure_password

  normalizes :email, with: ->(email) { email.strip.downcase }
  
  has_many :wishes, dependent: :destroy
  has_many :wished_spots, through: :wishes, source: :spot
  
  enum :role, { visitor: 0, admin: 1 }
  
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 8 }, allow_nil: true
end