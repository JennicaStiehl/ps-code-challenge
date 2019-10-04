require 'csv'

class ImportOutput
  def self.banner text
    puts " #{text}"
  end
end

namespace :import do
  desc "import cafe data"
  task cafe_data: :environment do
    ImportOutput.banner "Import in progress."
    CSV.foreach('./lib/assets/resources.csv', headers: true) do |row|
      Restaurant.create(cafe_name: row["Cafe Name"],street_address: row["Street Address"], post_code: row["Post Code"], number_of_chairs: row["Number of Chairs"] )
    end
    Restaurant.update_category
    ImportOutput.banner "Import finished."
  end
end
