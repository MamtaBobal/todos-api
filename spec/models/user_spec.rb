require 'rails_helper'

RSpec.describe User, type: :model do
  
  # Associations
  it { should have_many(:todos) }

  # Validations
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password_digest) }
end
