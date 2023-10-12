class Plot < ApplicationRecord
  has_many :organisms
  default_scope { order(created_at: :asc) }
end