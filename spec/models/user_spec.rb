require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  it "is valid with valid attributes" do
    expect(user).to be_valid
  end

  it "is invalid with invalid attributes" do
    user = User.new()
    expect(user).to_not be_valid
  end

  describe "Associations" do
		it { have_many(:complaints) }
	end
end
