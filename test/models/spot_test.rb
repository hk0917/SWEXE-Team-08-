require "test_helper"

class SpotTest < ActiveSupport::TestCase
  setup do
    @area = Area.create!(name: "テストエリア")
  end

  def build_spot(**attrs)
    Spot.new({ area: @area, name: "観光地", category: "自然" }.merge(attrs))
  end

  test "http(s)のURLは保存できる" do
    assert build_spot(image_url: "https://example.com/a.png", official_url: "http://example.com/").valid?
  end

  test "不正なURLは保存できない" do
    ["javascript:alert(1)", "foo", "http://", "https://a b", "ftp://example.com"].each do |url|
      spot = build_spot(official_url: url)
      assert_not spot.valid?, "#{url} は不正なURLとして弾かれるはず"
      assert spot.errors[:official_url].any?
    end
  end

  test "noticeは200文字まで" do
    assert build_spot(notice: "あ" * 200).valid?
    assert_not build_spot(notice: "あ" * 201).valid?
  end
end