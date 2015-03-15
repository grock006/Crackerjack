class Restaurant < ActiveRecord::Base
	validates :name, uniqueness: true
	validates :rating, numericality: { greater_than: 0}
	validates :total_reviews, numericality: { greater_than: 0}
end
