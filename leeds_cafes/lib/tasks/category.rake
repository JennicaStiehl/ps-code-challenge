require 'csv'

class CategoryOutput
  def self.banner text
    puts " #{text}"
  end
end

namespace :category do
  desc "categorizes each cafe based on size and location"
  CategoryOutput.banner "Category update: add categories in progress."
    task add_categories: :environment do
      cafes = Restaurant.where("post_code like 'LS1 %' and number_of_chairs < 10")
      cafes.update_all "category = 'ls1 small'"
      CategoryOutput.banner "Category update: add categories finished."
    end

  desc "removes all cafes categorized as small from the database and into a new file"
  task remove_small_cafes: :environment do 
    CategoryOutput.banner "Category update: remove small cafes in progress."
    file = './lib/assets/small_cafes.csv'
    Restaurant.update_category
    small_cafes = Restaurant.find_small_cafes
    CSV.open( file, 'w', :write_headers=> true,
      :headers => ["cafe_name","post_code","street_address", "category", "number of chairs"] ) do |writer|
      small_cafes.each do |c|
        writer << [c.cafe_name, c.post_code, c.street_address, c.category, c.number_of_chairs ]
      end
    end
    CategoryOutput.banner "Category update: remove small cafes finished."
  end

  desc "For street cafes categorized as medium or large, write a script that concatenates the category name to the beginning of the name and writes it back to the name column"
  task rename_cafes: :environment do
    CategoryOutput.banner "Category update: rename cafes in progress."
    med_lg_cafes = Restaurant.find_med_lg_cafes
    med_lg_cafes.update_all "cafe_name = concat(category, ' - ', cafe_name)"
    CategoryOutput.banner "Category update: rename cafes finished."
  end
end
