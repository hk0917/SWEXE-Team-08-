module SpotsHelper
  def http_url?(value)
    HttpUrlValidator.http_url?(value)
  end

  # image_url が正しい http(s) のURLのときだけ画像を出す。それ以外は「画像なし」
  def spot_image_tag(spot, css_class)
    if http_url?(spot.image_url)
      image_tag spot.image_url, alt: spot.name, class: css_class
    else
      content_tag :div, "画像なし", class: [css_class, "spot-no-image"]
    end
  end
end