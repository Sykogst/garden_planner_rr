require 'rails_helper'

RSpec.describe Plot, type: :model do
  it { should have_many :organisms }
end