class Organism < ApplicationRecord
  belongs_to :plot

  def self.only_alive
    self.where(alive: true)
  end
end