class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :title
      t.string :name
      t.string :content
      t.integer :score

      t.timestamps null: false
    end
  end
end
