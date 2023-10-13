class Plot < ApplicationRecord
  has_many :organisms
  default_scope { order(created_at: :asc) } # Not sure if the sort should go here or in controller

  def organisms_count
    self.organisms.count
  end
end