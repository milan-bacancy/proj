class User < ApplicationRecord

	has_many :complaints, dependent: :destroy
	enum role: [:user, :admin]
	enum gender: [:male, :female]
	validates_each :fname do |record, attr, value|
    record.errors.add(attr, 'must start with upper case') if value =~ /\A[[:lower:]]/
  end
	validates_each :lname do |record, attr, value|
    record.errors.add(attr, 'must start with upper case') if value =~ /\A[[:lower:]]/
  end
  validates :address, presence: true
  validates :contact, presence:true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :rememberable, :validatable
end
