class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_view :categories
  end
end
