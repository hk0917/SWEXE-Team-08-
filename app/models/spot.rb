class Spot < ApplicationRecord
  CATEGORIES = %w[自然 歴史 グルメ 体験].freeze

  belongs_to :area
  has_many :wishes, dependent: :destroy
  has_many :wished_users, through: :wishes, source: :user
  validates :name, :category, presence: true

  scope :in_area,     ->(area_id)  { where(area_id: area_id) if area_id.present? }
  scope :in_category, ->(category) { where(category: category) if category.present? }
  scope :with_wishes_total, -> {
    left_joins(:wishes).group("spots.id").select("spots.*, COUNT(wishes.id) AS wishes_total")
  }
  scope :popular, -> { order(Arel.sql("COUNT(wishes.id) DESC, spots.id ASC")) }
  scope :newest,  -> { order(created_at: :desc) }
end