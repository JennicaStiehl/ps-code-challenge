class PostCode < ApplicationRecord
  self.primary_key = 'pc_id'

  def self.refresh
    Scenic.database.refresh_materialized_view(:post_codes, concurrently: false, cascade: false)
  end

  private
  def readonly?
    true
  end
end
