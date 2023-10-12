require 'rails_helper'

RSpec.describe Organism, type: :model do
  it { should belong_to :plot }
end