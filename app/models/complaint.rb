class Complaint < ApplicationRecord
  belongs_to :user

  enum status: [:ongoing, :resolved]
end
