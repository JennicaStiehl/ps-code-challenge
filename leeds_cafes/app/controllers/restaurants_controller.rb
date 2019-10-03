class RestaurantsController < ApplicationController
  def index
    @title = params["post_code"]
    @cafes = Restaurant.find_by_post_code(@title)
    @total_chairs = Restaurant.total_chairs(@title)
    @total_places = Restaurant.total_places(@title)
    @chairs_pct = Restaurant.chairs_pct(@title)
    @max_chairs = Restaurant.max_chairs(@title)
  end
end
