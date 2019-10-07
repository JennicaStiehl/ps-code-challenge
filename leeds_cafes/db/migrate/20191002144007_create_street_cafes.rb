class CreatePostCodes < ActiveRecord::Migration[5.2]
  def change
    create_view :post_codes, materialized: true
  end
end
