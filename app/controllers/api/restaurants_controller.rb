module Api
  class RestaurantsController < ApplicationController

    def index
      
      restaurants = Restaurant.all
      # restaurant = restaurants[0][:name] 
      restaurants.uniq {|x| x[:name]}

      render json: restaurants.to_json, only: :id
      
    end

    def show
      restaurant = Restaurant.find(params[:id])
      render json: restaurant.to_json
    end

    def create
      restaurant = Restaurant.new(restaurant_params)

      if restaurant.save
        render json: restaurant, location: [:api, restaurant]
      else
        render json: {restaurant: restaurant, errors: restaurant.errors.full_messages}, status: 422
      end
    end


  private
    def restaurant_params
      params.require(:review).permit(:name, :location, :content, :total_reviews, :positive_reviews, :negative_reviews, :rating)
    end


  end
end