class HomeController < ApplicationController
  def top
    @areas = Area.order(:id)
    @popular_spots = Spot.left_joins(:wishes)
                         .group("spots.id")
                         .select("spots.*, COUNT(wishes.id) AS wishes_total")
                         .order(Arel.sql("COUNT(wishes.id) DESC, spots.id ASC"))
                         .limit(3)
  end
end