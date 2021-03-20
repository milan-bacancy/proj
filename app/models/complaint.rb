class Complaint < ApplicationRecord
  belongs_to :user

  enum status: [:ongoing, :resolved]
  validates :title, presence: true
  validates :desc, presence: true
end
