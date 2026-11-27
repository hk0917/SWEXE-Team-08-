class User < ApplicationRecord
  has_secure_password

  normalizes :email, with: ->(email) { email.strip.downcase }
  
  has_many :wishes, dependent: :destroy
  has_many :wished_spots, through: :wishes, source: :spot
  
  enum :role, { visitor: 0, admin: 1 }
  
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  
  # 更新時にパスワード欄が空でも通す（将来のプロフィール編集用）。
  # 新規登録の必須チェックは has_secure_password が行う
  validates :password, length: { minimum: 8 }, allow_nil: true
end