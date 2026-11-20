class SpotsController < ApplicationController
  SORTS = %w[popular newest].freeze

  def index
    @areas      = Area.order(:id)
    @categories = Spot::CATEGORIES
    @sort       = params[:sort].presence_in(SORTS) || "popular"

    spots = Spot.includes(:area)
                .in_area(params[:area_id])
                .in_category(params[:category])
                .with_wishes_total

    @spots = (@sort == "newest" ? spots.newest : spots.popular).to_a
  end
end