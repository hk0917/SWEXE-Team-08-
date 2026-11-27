module SpotsHelper
  # image_url が http(s) で始まるときだけ画像を出す。それ以外は「画像なし」
  def spot_image_tag(spot, css_class)
    if spot.image_url.to_s.start_with?("http://", "https://")
      image_tag spot.image_url, alt: spot.name, class: css_class
    else
      content_tag :div, "画像なし", class: [css_class, "spot-no-image"]
    end
  end
end