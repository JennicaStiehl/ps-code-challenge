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

  def self.update_category
    self.update_ls1
    self.update_ls2
    self.update_other
  end

  def self.find_ls2
    where(post_code: 'LS2')
  end

  def self.update_ls2
    to_update = self.find_ls2
    to_update.each do |cafe|
      if cafe.number_of_chairs < (self.total_chairs('LS2') / 2)
        cafe.update(category: 'ls2 small')
      else
        cafe.update(category:  'ls2 large')
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
      SET category = 'ls1 small'
      WHERE post_code = 'LS1' and number_of_chairs < 10;
      ")
  end

  def self.update_ls1_medium
    results = ActiveRecord::Base.connection.execute("
      UPDATE restaurants
      SET category = 'ls1 medium'
      WHERE post_code = 'LS1' and number_of_chairs >= 10 and number_of_chairs < 100;
      ")
  end

  def self.update_ls1_large
    results = ActiveRecord::Base.connection.execute("
      UPDATE restaurants
      SET category = 'ls1 large'
      WHERE post_code = 'LS1' and number_of_chairs >= 100;
      ")
  end

end
