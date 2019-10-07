class PostCode < ApplicationRecord
  # self.primary_key = 'pc_id'

  def self.refresh
    Scenic.database.refresh_materialized_view(:post_codes, concurrently: false, cascade: false)
  end

  def self.find_by_post_code(value)
    where("post_code like '#{value}%'")
  end

  private
  def readonly?
    true
  end
end
