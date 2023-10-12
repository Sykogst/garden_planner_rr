require 'rails_helper'

RSpec.describe Organism do
  it { should belong_to :plot }
end