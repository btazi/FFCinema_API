require 'rails_helper'

RSpec.describe User, type: :model do

  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to validate_presence_of(:role) }

  it { is_expected.to have_many(:reviews)}

  it "expects a new user to have the moviegoer role" do
    user = User.new(email: "test@example.com", password: "password", password_confirmation: "password")
    expect(user.role).to eq("moviegoer")
  end
end
