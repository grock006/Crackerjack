class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :location
      t.string :content
      t.integer :total_reviews
      t.integer :positive_reviews
      t.integer :negative_reviews

      t.timestamps null: false
    end
  end
end
