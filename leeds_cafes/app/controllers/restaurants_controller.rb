class RestaurantsController < ApplicationController

  def index
    @filter_by = params["filter_by"]
    @title = params["value"]
    @cafes = Restaurant.find_by_filter(@title, @filter_by)
    @total_chairs = Restaurant.total_chairs(@title, @filter_by)
    @total_places = Restaurant.total_places(@title, @filter_by)
    @chairs_pct = Restaurant.chairs_pct(@title, @filter_by)
    @max_chairs = Restaurant.max_chairs(@title, @filter_by)
  end

end
