module Api
  class ReviewsController < ApplicationController

    def index
      reviews = Review.all
      render json: reviews.to_json, only: :id
    end

    def show
        review = Review.find(params[:id])
      render json: review.to_json
    end

    def create
      review = Review.new(review_params)

      if review.save
        render json: review, location: [:api, review]
      else
        render json: {review: review, errors: review.errors.full_messages}, status: 422
      end
    end

  private
    def review_params
      params.require(:review).permit(:title, :name, :content, :score, :restaurant)
    end


  end
end