class ReviewsController < ApplicationController

  def new
    @user = current_user
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @restaurant.reviews.create(reviews_params)
    redirect_to '/restaurants'
  end

private

  def reviews_params
    params.require(:review).permit(:thoughts, :rating, :restaurant_id, :user_id)
  end

end
