class Review < ApplicationRecord
  validates :rating, inclusion: (1..5)
  belongs_to :user
  belongs_to :restaurant
  validates :user, uniqueness: { scope: :restaurant, message: 'you have reviewed this already'}
  has_many :endorsements
end
