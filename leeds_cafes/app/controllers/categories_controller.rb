class CategoriesController < ApplicationController

  def index
    @title = params["category"]
    @results = Category.all
  end

end
