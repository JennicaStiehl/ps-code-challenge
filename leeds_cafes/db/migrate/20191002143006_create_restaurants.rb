class CreateRestaurants < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurants do |t|
      t.string :cafe_name
      t.string :street_address
      t.string :post_code
      t.integer :number_of_chairs
      t.string :category
      t.timestamps
    end
  end
end
