require 'csv'

namespace :category do
  desc "removes all cafes categorized as small from the database and into a new file"
  task remove_small_cafes: :environment do
    file = './lib/assets/small_cafes.csv'
    Restaurant.update_category
    small_cafes = Restaurant.find_small_cafes
    CSV.open( file, 'w', :write_headers=> true,
      :headers => ["cafe_name","post_code","street_address", "category", "number of chairs"] ) do |writer|
      small_cafes.each do |c|
        writer << [c.cafe_name, c.post_code, c.street_address, c.category, c.number_of_chairs ]
      end
    end
    Restaurant.count
    small_cafes.count
    small_cafes.destroy_all
    Restaurant.count
    small_cafes.count
  end

  desc "For street cafes categorized as medium or large, write a script that concatenates the category name to the beginning of the name and writes it back to the name column"
  task rename_cafes: :environment do
    med_lg_cafes = Restaurant.find_med_lg_cafes
    med_lg_cafes.update_all "cafe_name = concat(category, ' - ', cafe_name)"
  end

end
