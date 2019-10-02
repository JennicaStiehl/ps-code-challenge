class StreetCafe < ApplicationRecord
  validates_presence_of :category
  validates_presence_of :post_code
end
