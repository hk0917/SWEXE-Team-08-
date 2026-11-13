class User < ApplicationRecord
  has_secure_password
  has_many :wishes, dependent: :destroy
  has_many :wished_spots, through: :wishes, source: :spot
  enum :role, { visitor: 0, admin: 1 }
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
end