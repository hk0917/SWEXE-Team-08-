class Spot < ApplicationRecord
  CATEGORIES = %w[自然 歴史 グルメ 体験].freeze

  belongs_to :area
  has_many :wishes, dependent: :destroy
  has_many :wished_users, through: :wishes, source: :user

  validates :name, presence: true
  validates :category, inclusion: { in: CATEGORIES }
  validates :image_url,
            format: { with: %r{\Ahttps?://}i, message: "は http:// か https:// で始まるURLにしてください" },
            allow_blank: true

  scope :in_area,     ->(area_id)  { where(area_id: area_id) if area_id.present? }
  scope :in_category, ->(category) { where(category: category) if category.present? }

  # with_wishes_total は「行きたい」の件数（wishes_total）を付ける。
  # popular は COUNT(wishes.id) で並べるので、必ず with_wishes_total と一緒に使う
  # （popular だけだと SQL エラーになる）。
  scope :with_wishes_total, -> {
    left_joins(:wishes).group("spots.id").select("spots.*, COUNT(wishes.id) AS wishes_total")
  }
  scope :popular, -> { order(Arel.sql("COUNT(wishes.id) DESC, spots.id ASC")) }
  scope :newest,  -> { order(created_at: :desc, id: :desc) }
end