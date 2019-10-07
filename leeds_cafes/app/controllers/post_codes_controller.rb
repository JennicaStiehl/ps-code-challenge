class PostCodesController < ApplicationController

  def index
    @title = params["post_code"]
    @results = PostCode.all #find_by_post_code(params["post_code"])
  end

end
