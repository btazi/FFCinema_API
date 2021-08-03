require 'rails_helper'

RSpec.describe Review, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to validate_presence_of(:user)}

  it { is_expected.to belong_to(:movie) }
  it { is_expected.to validate_presence_of(:movie)}

  it {is_expected.to validate_presence_of(:rating)}
  it {is_expected.to validate_numericality_of(:rating).is_less_than(10).is_greater_than(0)}
end
