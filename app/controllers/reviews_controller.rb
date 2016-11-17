class ReviewsController < ApplicationController
before_action :authenticate_user!

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    restaurant = Restaurant.find(params[:restaurant_id])
    if current_user.has_reviewed? restaurant
      flash[:notice] = "You've already reviewed this restaurant"
    else
      review = Review.new(review_params)
      review.user_id = current_user.id
      review.restaurant_id = restaurant.id
      review.save
    end
    redirect_to "/restaurants"
  end

  private
  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end
end
