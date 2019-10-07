class Category < ApplicationRecord
  # self.primary_key = 'c_id'

  def self.refresh
    Scenic.database.refresh_materialized_view(:categories, concurrently: false, cascade: false)
  end

  def self.find_by_category(value)
    where("category like '#{value}%'")
  end

  private
  def readonly?
    true
  end
end
