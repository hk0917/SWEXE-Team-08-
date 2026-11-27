require "test_helper"

class SpotsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @area  = Area.create!(name: "テストエリア")
    @other = Area.create!(name: "別エリア")
    @spot  = Spot.create!(area: @area, name: "観光地A", category: "自然")
  end

  test "存在しないIDは404になる" do
    get "/spots/0"
    assert_response :not_found
  end

  test "お知らせと公式サイトは、登録があるときだけ表示される" do
    get spot_path(@spot)
    assert_response :success
    assert_select ".spot-notice", count: 0
    assert_select "a[target=_blank]", count: 0

    @spot.update!(notice: "臨時休業", official_url: "https://example.com/")
    get spot_path(@spot)
    assert_select ".spot-notice", text: /臨時休業/
    assert_select "a[target=_blank][rel=noopener][href=?]", "https://example.com/"
  end

  test "説明が空のときは未登録と表示する" do
    get spot_path(@spot)
    assert_select "p", text: "未登録", minimum: 1
  end

  test "近くのおすすめが0件のときは案内を表示する" do
    get spot_path(@spot)
    assert_select ".nearby-spot", count: 0
    assert_select "p", text: /まだ登録されていません/
  end

  test "近くのおすすめが1件のとき、1件表示される" do
    Spot.create!(area: @area, name: "観光地B", category: "歴史")
    get spot_path(@spot)
    assert_select ".nearby-spot", count: 1
  end

  test "近くのおすすめは、同じエリアで自分自身を含まず、最大2件" do
    %w[B C D].each { |name| Spot.create!(area: @area, name: "観光地#{name}", category: "歴史") }
    Spot.create!(area: @other, name: "別エリアの観光地", category: "歴史")

    get spot_path(@spot)
    assert_select ".nearby-spot", count: 2
    assert_select ".nearby-spot a", text: "観光地A", count: 0
    assert_select ".nearby-spot a", text: "別エリアの観光地", count: 0
  end
end