require 'rails_helper'

RSpec.describe Todo, type: :model do
  # Association test
  it { should have_many(:items).dependent(:destroy) }
  # Validation tests
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:created_by) }

end
