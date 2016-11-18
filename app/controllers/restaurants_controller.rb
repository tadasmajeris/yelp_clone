class RestaurantsController < ApplicationController
before_action :authenticate_user!, :except => [:index, :show]

  def index
    @restaurants = Restaurant.all
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.user_id = current_user.id
    if @restaurant.save
      flash[:notice] = 'Restaurant added successfully'
      redirect_to restaurants_path
    else
      render "new"
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    @restaurant.update(restaurant_params) if @restaurant.belongs_to?(current_user)
    redirect_to "/restaurants"
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    if @restaurant.belongs_to?(current_user)
      @restaurant.destroy
      flash[:notice]= "Restaurant successfully deleted"
    end
    redirect_to '/restaurants'
  end

  private
  def restaurant_params
    list_params_allowed = [:name, :description]
    params.require(:restaurant).permit(list_params_allowed)
  end
end
