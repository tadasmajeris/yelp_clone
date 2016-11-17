module ReviewsHelper
  def star_rating(rating)
    return 'N/A' if rating == 'N/A'
    '★' * rating.round + '☆' * (5 - rating.round)
  end
end
