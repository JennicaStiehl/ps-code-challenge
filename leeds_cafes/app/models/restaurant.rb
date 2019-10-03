class Restaurant < ApplicationRecord
  validates_presence_of :post_code

  def self.find_by_filter(value, filter_by)
    if filter_by == 'post_code'
      where("#{filter_by} like '#{value} %'")
    elsif filter_by == 'category'
      where("#{filter_by} = '#{value}'")
    end
  end

  def self.total_chairs(value, filter_by)
      cafes = self.find_by_filter(value, filter_by)
      cafes.sum(:number_of_chairs)
  end

  def self.total_places(value, filter_by)
    cafes = self.find_by_filter(value, filter_by)
    cafes.count(:cafe_name)
  end

  def self.all_chairs
    sum(:number_of_chairs)
  end

  def self.chairs_pct(value, filter_by)
    ((self.total_chairs(value, filter_by).to_f / self.all_chairs)*100).round(2)
  end

  def self.max_chairs(value, filter_by)
    cafes = self.find_by_filter(value, filter_by)
    cafes.select("restaurants.*, coalesce(max(number_of_chairs),0) as most_chairs")
    .group("restaurants.id")
    .order("most_chairs desc")
    .limit(1)
  end

  def self.update_category
    self.update_ls1
    self.update_ls2
    self.update_other
  end

  def self.find_ls2
    where("post_code like 'LS2 %'")
  end

  def self.update_ls2
    to_update = self.find_ls2
    to_update.each do |cafe|
      if cafe.number_of_chairs < (self.total_chairs('LS2', 'post_code') / 2)
        cafe.update(category: 'ls2_small')
      else
        cafe.update(category:  'ls2_large')
      end
    end
  end

  def self.find_others
    where('category is null')
  end

  def self.update_other
    to_update = self.find_others
    to_update.each do |cafe|
      cafe.update(category:  'other')
    end
  end

  def self.update_ls1
    self.update_ls1_small
    self.update_ls1_medium
    self.update_ls1_large
  end

  def self.update_ls1_small
    results = ActiveRecord::Base.connection.execute("
      UPDATE restaurants
      SET category = 'ls1_small'
      WHERE post_code like 'LS1 %' and number_of_chairs < 10;
      ")
  end

  def self.update_ls1_medium
    results = ActiveRecord::Base.connection.execute("
      UPDATE restaurants
      SET category = 'ls1_medium'
      WHERE post_code like 'LS1 %' and number_of_chairs >= 10 and number_of_chairs < 100;
      ")
  end

  def self.update_ls1_large
    results = ActiveRecord::Base.connection.execute("
      UPDATE restaurants
      SET category = 'ls1_large'
      WHERE post_code like 'LS1 %' and number_of_chairs >= 100;
      ")
  end

  def self.find_small_cafes
    where("category like '%small'")
  end

  def self.find_med_lg_cafes
    where("category like '%medium' or category like '%large'")
  end

end
