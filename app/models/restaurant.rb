class Restaurant < ActiveRecord::Base
	validates :name, uniqueness: true
end
