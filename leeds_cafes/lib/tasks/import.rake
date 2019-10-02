require 'CSV'

namespace :import do
  desc "import cafe data"
  task cafe_data: :environment do
    arr_of_rows = CSV.read('./lib/assets/resources.csv')
    CSV.foreach('./lib/assets/resources.csv', headers: true) do |row|
      StreetCafe.create(row)
    end
  end

end
