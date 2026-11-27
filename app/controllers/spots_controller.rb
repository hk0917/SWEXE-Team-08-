class SpotsController < ApplicationController
  SORT_OPTIONS = { "popular" => "人気順", "newest" => "新着順" }.freeze

  def index
    @areas        = Area.order(:id)
    @categories   = Spot::CATEGORIES
    @sort_options = SORT_OPTIONS

    # 配列やハッシュ（?area_id[a]=1 など）が来ても落ちないよう、文字列にそろえる
    @area_id  = params[:area_id].to_s
    @category = params[:category].to_s
    @sort     = params[:sort].to_s.presence_in(SORT_OPTIONS.keys) || "popular"

    spots = Spot.includes(:area)
                .in_area(@area_id)
                .in_category(@category)
                .with_wishes_total

    @spots = (@sort == "newest" ? spots.newest : spots.popular).to_a
  end

  def show
    # 存在しないIDは RecordNotFound になり、本番では 404 になる
    @spot         = Spot.includes(:area).find(params[:id])
    @wishes_count = @spot.wishes.count
    @nearby_spots = Spot.where(area_id: @spot.area_id)
                        .where.not(id: @spot.id)
                        .order(:id)
                        .limit(2)
  end
end