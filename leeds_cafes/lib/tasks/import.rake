require 'csv'

namespace :import do
  desc "import cafe data"
  task cafe_data: :environment do
    CSV.foreach('./lib/assets/resources.csv', headers: true) do |row|
      Restaurant.create(cafe_name: row["Cafe Name"],street_address: row["Street Address"], post_code: row["Post Code"], number_of_chairs: row["Number of Chairs"] )
    end
  end
  # desc "update records"
  # task add_category: :environment do
  #   Restaurant.update(category: 'ls1 small')
  #   .where(post_code: 'LS1')
  #   .where('number_of_chairs < 10')
  # end
end
