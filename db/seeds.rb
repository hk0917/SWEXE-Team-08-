# エリア
areas = %w[広島市周辺 備後地方 県北部 呉・島しょ部 県西部].index_with do |name|
  Area.find_or_create_by!(name: name)
end

# 観光地（宮島・原爆ドームは含めない）
spots = [
  { name: "広島城",           area: "広島市周辺",   category: "歴史", address: "広島県広島市中区" },
  { name: "縮景園",           area: "広島市周辺",   category: "自然", address: "広島県広島市中区" },
  { name: "千光寺公園",       area: "備後地方",     category: "自然", address: "広島県尾道市" },
  { name: "鞆の浦",           area: "備後地方",     category: "歴史", address: "広島県福山市" },
  { name: "福山城",           area: "備後地方",     category: "歴史", address: "広島県福山市" },
  { name: "帝釈峡",           area: "県北部",       category: "自然", address: "広島県庄原市" },
  { name: "三次の鵜飼",       area: "県北部",       category: "体験", address: "広島県三次市" },
  { name: "国営備北丘陵公園", area: "県北部",       category: "自然", address: "広島県庄原市" },
  { name: "大和ミュージアム", area: "呉・島しょ部", category: "歴史", address: "広島県呉市" },
  { name: "大久野島",         area: "呉・島しょ部", category: "体験", address: "広島県竹原市" },
  { name: "三段峡",           area: "県西部",       category: "自然", address: "広島県山県郡安芸太田町" }
]

spots.each do |attrs|
  spot = Spot.find_or_initialize_by(name: attrs[:name])
  spot.area        = areas[attrs[:area]]
  spot.category    = attrs[:category]
  spot.address     = attrs[:address]
  spot.description = "（ここに見どころの説明を書く）"
  spot.access      = "（ここにアクセスを書く）"
  spot.save!
end

# ユーザー（開発用。パスワードは本番で使わない）
User.find_or_create_by!(email: "admin@example.com") do |u|
  u.name = "管理者"
  u.password = "password"
  u.role = :admin
end

User.find_or_create_by!(email: "visitor@example.com") do |u|
  u.name = "観光客"
  u.password = "password"
  u.role = :visitor
end