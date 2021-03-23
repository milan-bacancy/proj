require 'rails_helper'

RSpec.describe Complaint, type: :model do
  let(:user) { create(:user) }
  let(:complaint) { build(:complaint) }

  it "is valid with valid attributes" do
    user.save
    complaint.user = user
    expect(complaint).to be_valid
  end
end
