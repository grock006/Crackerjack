class AddRestaurantToReviews < ActiveRecord::Migration
  def change
  	add_column :reviews, :restaurant, :string
  end
end
