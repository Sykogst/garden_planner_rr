class Plot < ApplicationRecord
  has_many :organisms, dependent: :delete_all
  
  def self.created_at_order_asc
    self.order(created_at: :asc)
  end

  def organisms_count
    self.organisms.count
  end

  def organisms_sort_by(column)
    self.organisms.order(column)
  end
end