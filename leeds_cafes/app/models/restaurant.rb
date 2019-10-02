class Restaurant < ApplicationRecord
  validates_presence_of :post_code

  def self.total_chairs(post_code)
    where(post_code: post_code).sum(:number_of_chairs)
  end
  def self.total_places(post_code)
    where(post_code: post_code).count(:cafe_name)
  end
  def self.chairs_pct(post_code)
    (self.total_chairs(post_code).to_f / self.total_places(post_code)).round(2)
  end
  def self.max_chairs(post_code)
    where(post_code: post_code).maximum(:number_of_chairs)
  end
end
