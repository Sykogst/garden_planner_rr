class Organism < ApplicationRecord
  belongs_to :plot

  def self.alive_true_all
    self.where(alive: true)
  end
end