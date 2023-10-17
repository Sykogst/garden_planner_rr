class Organism < ApplicationRecord
  belongs_to :plot

  def self.alive_true_all
    where(alive: true)
  end

  # This works for filtering ALL organisms, not per specific plot
  def self.size_greater_than(threshold)
    where("cast(max_size_sqft as float) > ?", threshold)
  end

  def self.search_by(params)
    where('lower(name) like ?', "%#{params.downcase}%")
  end
end