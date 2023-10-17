class Plot < ApplicationRecord
  has_many :organisms, dependent: :delete_all
  
  def self.created_at_order_asc
    order(created_at: :asc)
  end

  def organisms_count
    self.organisms.count
  end

  def organisms_sort_by(column)
    self.organisms.order(column)
  end

  # This filter works for a specific plot
  def organisms_size_greater_than(threshold)
    self.organisms.where("cast(max_size_sqft as float) > ?", threshold)
  end

  def self.search_by(params)
    where('name like ?', "%#{params}%")
  end
end