class Spot < ApplicationRecord
  belongs_to :area
  has_many :wishes, dependent: :destroy
  has_many :wished_users, through: :wishes, source: :user
  validates :name, :category, presence: true
end