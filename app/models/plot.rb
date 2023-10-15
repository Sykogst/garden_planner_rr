class Plot < ApplicationRecord
  has_many :organisms
  
  def self.created_at_order_asc
    self.order(created_at: :asc)
  end

  def organisms_count
    self.organisms.count
  end

  def sort_alphabetical(column)
    self.organisms.order(column)
  end
end