class AddColumnToRestaurants < ActiveRecord::Migration
  def change
  	add_column :restaurants, :rating, :float
  end
end
