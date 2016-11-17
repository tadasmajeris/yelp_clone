class ReviewsController < ApplicationController

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.reviews.new(reviews_params)
    @review.user = current_user
    if @review.save
      redirect_to restaurant_path(params[:restaurant_id])
    else
      render 'new'
    end
  end

  private

  def reviews_params
    params.require(:review).permit(:thoughts, :rating)
  end

end
