class Restaurant < ApplicationRecord
  has_many :reviews, dependent: :destroy
  belongs_to :user
  validates :name, length: {minimum: 3}, uniqueness: true

  def belongs_to?(user)
    user ? self.user_id == user.id : false
  end

  def build_review(review_params, user)
    review = reviews.build(review_params)
    review.user = user
    return review
  end


end
