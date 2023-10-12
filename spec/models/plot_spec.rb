require 'rails_helper'

RSpec.describe Plot do
  it { should have_many :organisms }
end