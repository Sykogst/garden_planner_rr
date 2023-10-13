class Plot < ApplicationRecord
  has_many :organisms
  default_scope { order(created_at: :asc) } # Not sure if the order should be a method, or in a controller

  def organisms_count
    self.organisms.count
  end
end